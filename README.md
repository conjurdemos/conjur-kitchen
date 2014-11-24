# rabbitmq_with_conjur

This is an example cookbook, showing how to pass secrets to test-kitchen via conjur.

We define the secrets we need in the `.conjurenv` file, like so:

```
rabbitmq_username: !var webinar-example/rabbitmq/username
rabbitmq_password: !var webinar-example/rabbitmq/password
```

Where `rabbitmq_username` is the environment variable that will be set in the context
of the `conjur env run` command and `!var webinar-example/rabbitmq/username` is a
mapping to the variable id stored in conjur.

Then in our `kitchen.yml` file we use those environment variables to pass node attributes
to the rabbitmq cookbook.

To run:

`conjur env check` to make sure our secrets are available.

`conjur env run -- kitchen converge` to converge the node, with secret values passed in at runtime.

`conjur env run -- kitchen verify` to ensure default passwords have been overwritten. **TODO**
