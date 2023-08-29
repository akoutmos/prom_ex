# Introduction to Telemetry

This section serves as a quick primer for the Telemetry library, how it works, and how you can leverage it in your
applications. While there is nothing specific to PromEx here, but it is important to know how Telemetry works so that
you can effectively create your own PromEx plugins.

## What is Telemetry?

At a high level, Telemetry offers a means for libraries and applications to surface internal events. These events can
be emitted prior to starting some logical body of work, after the work has completed, after the processing of the work
has resulted in an exception, or even any time you want to denote that something of importance has occurred. As an
example, these events can include the time it takes to process incoming HTTP requests (like in Phoenix) or the time
it takes to process a job (like in Broadway & Oban) and well as metadata related to the event (like the requested route
in Phoenix).

## How Does it Work?

Under the hood, Telemetry works by attaching callback functions to events (tracked in ETS), and then invoking those
functions serially whenever that event occurs. In other words, any time an event is triggered, Telemetry dynamically
dispatches to each of the callbacks that are registered for that particular event. You can think of this as effectively
being a pub/sub style library but synchronous as opposed to asynchronous. Given that the callbacks are executed in a
synchronous fashion, it is highly recommended that you keep your callbacks very lightweight and functionally limited. If
additional blocking work needs to take place as a result of an event, be sure to spin that work off into its own Task or
pass it along to a separate GenServer.

## Why is Telemetry Important?

In my opinion, Telemetry (and the other repositories in the beam-telemetry GitHub organization) provides two key benefits
to the Erlang, Elixir and Beam communities.

Firstly, Telemetry provides a consistent interface through which applications and libraries can expose internal events.
This consistent interface consists of measurements and metadata that are attached to each event that can then be used by
consumers in whichever way fits the user's needs. For example, using the same Telemetry event, you can produce a custom
log message and even metrics by attaching two separate callback functions to the desired Telemetry event.

Secondly, attaching callbacks to Telemetry events is a very low friction operation and can be done without much
ceremony. This is important given that if the ergonomics of Telemetry were cumbersome to work with, library authors
would not be inclined to leverage Telemetry for surfacing internal events. Specifically, Telemetry does not require
any global setup or configuration by either the library author or the user. Instead, Telemetry will sort out the dynamic
function dispatch through ETS tables that it manages and will only invoke callback functions when callbacks have been
attached to a particular event.

As a result of these two points (and others), it is no surprise that over 100 libraries in the Elixir and Erlang
ecosystem have adopted Telemetry as their primary means of surfacing internal events.

## How Can I Use Telemetry in my Project?

As previously mentioned, leveraging Telemetry consists of a library (or your application) executing an event, and you as
the user attaching a callback to said event. As an example, let's suppose that we want to emit an event any time a user
registers for our service. In our registration function we could do something like so in order to capture when users are
successfully created and when errors are encountered:

```elixir
def register_user(attrs) do
  %User{}
  |> User.registration_changeset(updated_attrs)
  |> Repo.insert()
  |> case do
    {:ok, new_user} = result ->
      :telemetry.execute([:my_cool_app, :accounts, :new_user, :success], %{}, %{user: new_user})
      result

    {:error, changeset} = error ->
      :telemetry.execute([:my_cool_app, :accounts, :new_user, :error], %{}, %{error: changeset})
      error
  end
end
```

Elsewhere in your application code (perhaps where you initialize your application) you can attach to these events by
doing the following:

```elixir
:telemetry.attach(
  "my-handler-1",
  [:my_cool_app, :accounts, :new_user, :success],
  fn _event_name, _event_measurement, event_metadata, _config ->
    Logger.debug("User has registered: #{inspect(event_metadata)}")
  end,
  %{}
)

:telemetry.attach(
  "my-handler-2",
  [:my_cool_app, :accounts, :new_user, :error],
  fn _event_name, _event_measurement, event_metadata, _config ->
    Logger.warning("User failed to register: #{inspect(event_metadata)}")
  end,
  %{}
)
```

Now, any time an error occurs and a user fails to register a warning log is generated with the metadata related to the
error. Similarly, a debug log message is created any time a user is successfully created.

## Additional Resources

- https://github.com/beam-telemetry/telemetry
- https://hexdocs.pm/telemetry_metrics/Telemetry.Metrics.html
- https://keathley.io/blog/telemetry-conventions.html
