

require 'httparty'
require 'uri'

begin
  require 'yajl-ruby'
rescue LoadError => ex
  require 'json'
end

begin
  require 'yaml'
rescue LoadError => ex
end


# Onetime::API - v0.3
# 
# A basic client library for the onetimesecret.com API. 
#
# Usage:
#
#     api = OT::API.new 'delano@onetimesecret.com', '4eb33c6340006d6607c813fc7e707a32f8bf5342'
#
#     api.get '/status'     
#       # => {'status' => 'nominal'}
#
#     api.post '/generate', :passphrase => 'yourspecialpassphrase'
#       # => {'value' => '3Rg8R2sfD3?a', 'metadata_key' => '...', 'secret_key' => '...'}
#       
module Onetime
  class API
    include HTTParty
    LIB_HOME = File.expand_path File.dirname(__FILE__) unless defined?(Onetime::API::LIB_HOME)
    base_uri 'https://onetimesecret.com/api'
    format :json
    attr_reader :opts, :response, :custid, :key, :default_params
    attr_accessor :apiversion
    def initialize custid=nil, key=nil, opts={}
      unless ENV['ONETIME_HOST'].to_s.empty?
        self.class.base_uri ENV['ONETIME_HOST'] 
      end
      @apiversion = opts.delete(:apiversion) || opts.delete('apiversion') || 1
      @opts = opts
      @default_params = {}
      @custid = custid || ENV['ONETIME_ACCOUNT']
      @key = key || ENV['ONETIME_APIKEY']
      unless @custid.to_s.empty? || @key.to_s.empty?
        opts[:basic_auth] ||= { :username => @custid, :password => @key }
      end
    end
    def get path, params=nil
      opts = self.opts.clone
      opts[:query] = (params || {}).merge default_params
      execute_request :get, path, opts
    end
    def post path, params=nil
      opts = self.opts.clone
      opts[:body] = (params || {}).merge default_params
      execute_request :post, path, opts
    end
    def api_path *args
      args.unshift ['', "v#{apiversion}"] # force leading slash and version
      path = args.flatten.join('/')
      path.gsub '//', '/'
    end
    private
    def execute_request meth, path, opts
      path = api_path [path]
      @response = self.class.send meth, path, opts
      self.class.indifferent_params @response.parsed_response
    end
    class << self
      def web_uri *args
        uri = URI.parse(OT::API.base_uri)
        uri.path = web_path *args
        uri
      end
      def web_path *args
        args.unshift [''] # force leading slash
        path = args.flatten.join('/')
        path.gsub '//', '/'
      end
      def indifferent_params(params)
        if params.is_a?(Hash)
          params = indifferent_hash.merge(params)
          params.each do |key, value|
            next unless value.is_a?(Hash) || value.is_a?(Array)
            params[key] = indifferent_params(value)
          end
        elsif params.is_a?(Array)
          params.collect! do |value|
            if value.is_a?(Hash) || value.is_a?(Array)
              indifferent_params(value)
            else
              value
            end
          end
        end
      end
      def indifferent_hash
        Hash.new {|hash,key| hash[key.to_s] if Symbol === key }
      end
    end
    
    module VERSION
      def self.to_s
        load_config
        [@version[:MAJOR], @version[:MINOR], @version[:PATCH]].join('.')
      end
      def self.inspect
        to_s
      end
      def self.load_config
        require 'yaml'
        @version ||= YAML.load_file(File.join(LIB_HOME, '..', '..', 'VERSION.yml'))
      end
    end
    
  end
end
OT = Onetime unless defined?(OT)