# conjur-kitchen

This is an example cookbook, showing how to pass secrets to test-kitchen via conjur.

This demo is also described in the blog post [Infrastructure as Code - Don’t Let Security Slow You Down](http://blog.conjur.net/infrastructure-as-code-dont-let-security-slow-you-down).

We define the secrets we need in the `.conjurenv` file, like so:

```
rabbitmq_username: !var webinar-example/rabbitmq/username
rabbitmq_password: !var webinar-example/rabbitmq/password
```

Where `rabbitmq_username` is the environment variable that will be set in the context
of the `conjur env run` command and `!var webinar-example/rabbitmq/username` is a
mapping to the variable id stored in conjur.

**Note** When the environment variable is exported it will be uppercase, `RABBITMQ_USERNAME`.

Then in our `kitchen.yml` file we use those environment variables to pass node attributes
to the rabbitmq cookbook.

```
conjur env run => environment variables => test-kitchen
```

This flow can be used for any tool that can use environment variables.

## Setup

### Tools

Install the [conjur CLI](http://developer.conjur.net/setup/client_install/cli.html).

Install [ChefDK](https://downloads.getchef.com/chef-dk/) and activate it with: `chef shell-init <bash|zsh>`.

`gem install kitchen-docker` to get the test-kitchen docker driver.

### Secrets

Create the 2 secrets via the conjur CLI:

```
conjur variable create -v <username> webinar-example/rabbitmq/username
conjur variable create -v <password> webinar-example/rabbitmq/password
```

where `<username>` and `<password>` are the secret values you provide.

For a non-demo scenario, you would also use `--as-group` option to specify the appropriate
ownership for the secrets (e.g. `v1/developers` or `v1/ops`).

## Running the example

To run:

`conjur env check` to make sure our secrets are available.

`conjur env run -- kitchen converge` to converge the node, with secret values passed in at runtime.

`conjur env run -- kitchen verify` to ensure default passwords have been overwritten.

The test checks that rabbitmq default username and password are no longer `guest:guest`.

When you're done, destroy the container with `kitchen destroy`.
