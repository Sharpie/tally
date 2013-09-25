Tally
=====

Description
-----------

A Tally board for a Triage that takes Redmine updates
and counts who performed them. This allows us to track and score who
contributed the most updates and edits to tickets.

Assumes the Redmine instance has the plugin:

    https://github.com/Sharpie/redmine_updates_notifier

With the target URL for updates to set to the Tally server, for example:

    http://example.com:4567/tally


Requirements
------------

See the [Gemfile](Gemfile).

Deployment to Heroku
--------------------

1.  After cloning this repository, run:

        heroku create
        heroku addons:add heroku-postgresql:dev

2. The last command will return a database name that looks like `HEROKU_POSTGRES_SOMECOLOR`.
   Promote this database so that it is set in the environment as `DATABASE_URL`:

        heroku pg:promote HEROKU_POSTGRES_SOMECOLOR

Local Development
-----------------

Look at [.ruby-version](.ruby-version) and ensure you have the same version of ruby installed through rbenv, rvm or some other means.
Also, ensure bundler is installed.

1.  Set up the local environment using bundler:

        bundle install --path=vendor

2.  Run the Tally server:

        bundle exec foreman start -e dev.env

    This will run tally from the in-built Sinatra webserver as configured in `config.ru`.
    An in-memory SQLite3 database will be used as defined in the file `dev.env`.

3.  Browse to the Tally server at http://localhost:5000

4.  You can test the submission of events using the tally-submit
    command like so:

        bundle exec bin/tally-submit --server=http://localhost:5000/tally --first=Test --last=User --email=test@nodomain

Authors
-------

James Turnbull <james@lovedthanlost.net>
Charlie Sharpsteen <chuck@puppetlabs.com>

License
-------

    Author:: James Turnbull (<james@lovedthanlost.net>)
    Copyright:: Copyright (c) 2011 James Turnbull
    License:: Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
