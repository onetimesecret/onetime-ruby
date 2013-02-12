# One-Time Secret 0.5 #

**Keep sensitive info out of your chat logs & email.**

## Basic Usage ##

Use `onetime` to share something you know (a secret phrase, a special link, etc) or to generate a secret (e.g. a temporary password).

### onetime share ###

You can pipe it:

    $ echo "I STILL WATCH NIGHT COURT." | onetime
    https://onetimesecret.com/secret/mc5o2649tva6885wvyspm0flobsasin

You can type it:

    $ onetime
    Paste secret here (hit control-D to continue):
    I STILL WATCH NIGHT COURT.
    https://onetimesecret.com/secret/3djys3b7tridrcvbiprqjejz0c2g07x

And you can read from a file:

    $ <path/2/file onetime
    https://onetimesecret.com/secret/8f8k3ajhax87ctln3h6y11nsb4vf0wq

*Note that we don't use `cat` in that example! We don't want to provoke the [ire of Randal L. Schwartz](http://partmaps.org/era/unix/award.html).*


### onetime generate ###

    $ onetime generate
    Your secret: CttenFwzVpjs
    https://onetimesecret.com/secret/er5djg1wodsp5m32oyym489bnuhsfp6


### onetime get ###

You can retrieve a secret too:

    $ onetime get mc5o2649tva6885wvyspm0flobsasin
    I STILL WATCH NIGHT COURT.

The URI works too:

    $ onetime get https://onetimesecret.com/secret/mc5o2649tva6885wvyspm0flobsasin
    I STILL WATCH NIGHT COURT.

## Output Format ##

`onetime` also supports YAML, JSON, and to a limited extent CSV outputs. Specify the format using the `-f ` global option:

    $ onetime -f yaml generate
    ---
    value: MhYcuge9VxtX
    metadata_key: 4j1122kpd6clemp80gpobu9xfxsp7zu
    secret_key: 8f8k3ajhax87ctln3h6y11nsb4vf0wq
    ttl: 172800
    passphrase_required: false

## Installation ###

    $ [sudo] gem install onetime

    However, in order to be sure the code you're installing hasn't been tampered with, it's recommended that you verify the signiture[http://docs.rubygems.org/read/chapter/21]. To do this, you need to add my public key as a trusted certificate (you only need to do this once):

        # Add the public key as a trusted certificate
        # (You only need to do this once)
        $ curl -O https://raw.github.com/onetimesecret/onetime-ruby/master/gem-public_cert.pem
        $ gem cert --add gem-public_cert.pem

    Then, when install the gem, do so with high security:

        $ gem install onetime -P HighSecurity

    If you don't add the public key, you'll see an error like "Couldn't verify data signature". If you're still having trouble let me know and I'll give you a hand.

## More Info ##

* [API docs](https://onetimesecret.com/docs/api)
* [Codes](https://github.com/onetimesecret/onetime-ruby)
* [Rubgems](https://rubygems.org/gems/onetime)
* [One-Time Secret](https://onetimesecret.com/)

See also:

    $ onetime -h
    $ onetime show-commands
    $ onetime share -h
    $ onetime generate -h

## Thanks ##

* Kyle Dawkins for the [perl lib](https://github.com/quile/onetime-perl)
* Drew Carey for [tweeting about us](https://twitter.com/DrewFromTV/status/142730130689761280)


## License ##

See LICENSE.txt
