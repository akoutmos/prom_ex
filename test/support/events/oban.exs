[
  %{
    event: [:prom_ex, :oban, :queue, :limit, :proxy],
    measurements: %{limit: 5},
    metadata: %{name: Oban, queue: :default}
  },
  %{
    event: [:prom_ex, :oban, :queue, :limit, :proxy],
    measurements: %{limit: 25},
    metadata: %{name: Oban, queue: :events}
  },
  %{
    event: [:prom_ex, :oban, :queue, :limit, :proxy],
    measurements: %{limit: 10},
    metadata: %{name: Oban, queue: :media}
  },
  %{
    event: [:oban, :supervisor, :init],
    measurements: %{system_time: 1_613_452_097_830_599_300},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      pid: nil
    }
  },
  %{
    event: [:prom_ex, :oban, :queue, :limit, :proxy],
    measurements: %{limit: 10},
    metadata: %{name: Oban.SuperSecret, queue: :default}
  },
  %{
    event: [:prom_ex, :oban, :queue, :limit, :proxy],
    measurements: %{limit: 50},
    metadata: %{name: Oban.SuperSecret, queue: :events}
  },
  %{
    event: [:prom_ex, :oban, :queue, :limit, :proxy],
    measurements: %{limit: 20},
    metadata: %{name: Oban.SuperSecret, queue: :media}
  },
  %{
    event: [:oban, :supervisor, :init],
    measurements: %{system_time: 1_613_452_098_233_920_500},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      pid: nil
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 186_841_300},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 5,
      queue: "default"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 61_165_700},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 10,
      queue: "default"
    }
  },
  %{
    event: [:oban, :job, :exception],
    measurements: %{duration: 24_705_300, queue_time: 40_957_203_000},
    metadata: %{
      args: %{"sleep_time" => 1973},
      attempt: 1,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      error: %{
        __exception__: true,
        __struct__: ArithmeticError,
        message: "bad argument in arithmetic expression"
      },
      id: 197_079,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "secret",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 1973},
        attempt: 1,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {18633, 6},
          minute: 8,
          month: 2,
          second: 19,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "m8icetgo"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [],
        id: 197_079,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {61430, 6},
          minute: 7,
          month: 2,
          second: 38,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {61430, 6},
          minute: 7,
          month: 2,
          second: 38,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      kind: :error,
      max_attempts: 20,
      prefix: "secret",
      queue: "default",
      stacktrace: [
        {WebApp.Jobs.DefaultWorker, :perform, 1, [file: ~c"lib/web_app/jobs/default_worker.ex", line: 9]},
        {Oban.Queue.Executor, :perform_inline, 1, [file: ~c"lib/oban/queue/executor.ex", line: 168]},
        {Oban.Queue.Executor, :perform_inline, 1, [file: ~c"lib/oban/queue/executor.ex", line: 156]},
        {Oban.Queue.Executor, :call, 1, [file: ~c"lib/oban/queue/executor.ex", line: 79]},
        {Task.Supervised, :invoke_mfa, 2, [file: ~c"lib/task/supervised.ex", line: 90]},
        {Task.Supervised, :reply, 5, [file: ~c"lib/task/supervised.ex", line: 35]},
        {:proc_lib, :init_p_do_apply, 3, [file: ~c"proc_lib.erl", line: 249]}
      ],
      state: :failure,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :job, :exception],
    measurements: %{duration: 24_042_000, queue_time: 40_992_339_000},
    metadata: %{
      args: %{"sleep_time" => 3878},
      attempt: 2,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      error: %{
        __exception__: true,
        __struct__: ArithmeticError,
        message: "bad argument in arithmetic expression"
      },
      id: 196_624,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "secret",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 3878},
        attempt: 2,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {18633, 6},
          minute: 8,
          month: 2,
          second: 19,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "m8icetgo"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [
          %{
            "at" => "2021-02-16T05:07:20.026330Z",
            "attempt" => 1,
            "error" =>
              "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
          }
        ],
        id: 196_624,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {902_899, 6},
          minute: 7,
          month: 2,
          second: 18,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {26294, 6},
          minute: 7,
          month: 2,
          second: 38,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      kind: :error,
      max_attempts: 20,
      prefix: "secret",
      queue: "default",
      stacktrace: [
        {WebApp.Jobs.DefaultWorker, :perform, 1, [file: ~c"lib/web_app/jobs/default_worker.ex", line: 9]},
        {Oban.Queue.Executor, :perform_inline, 1, [file: ~c"lib/oban/queue/executor.ex", line: 168]},
        {Oban.Queue.Executor, :perform_inline, 1, [file: ~c"lib/oban/queue/executor.ex", line: 156]},
        {Oban.Queue.Executor, :call, 1, [file: ~c"lib/oban/queue/executor.ex", line: 79]},
        {Task.Supervised, :invoke_mfa, 2, [file: ~c"lib/task/supervised.ex", line: 90]},
        {Task.Supervised, :reply, 5, [file: ~c"lib/task/supervised.ex", line: 35]},
        {:proc_lib, :init_p_do_apply, 3, [file: ~c"proc_lib.erl", line: 249]}
      ],
      state: :failure,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :job, :exception],
    measurements: %{duration: 25_391_900, queue_time: 39_747_298_000},
    metadata: %{
      args: %{"sleep_time" => 1958},
      attempt: 2,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      error: %{
        __exception__: true,
        __struct__: ArithmeticError,
        message: "bad argument in arithmetic expression"
      },
      id: 195_899,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "public",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 1958},
        attempt: 2,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {968_847, 6},
          minute: 8,
          month: 2,
          second: 18,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "4gtct002"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [
          %{
            "at" => "2021-02-16T05:07:24.221577Z",
            "attempt" => 1,
            "error" =>
              "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
          }
        ],
        id: 195_899,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {611_691, 6},
          minute: 7,
          month: 2,
          second: 22,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {221_549, 6},
          minute: 7,
          month: 2,
          second: 39,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      kind: :error,
      max_attempts: 20,
      prefix: "public",
      queue: "default",
      stacktrace: [
        {WebApp.Jobs.DefaultWorker, :perform, 1, [file: ~c"lib/web_app/jobs/default_worker.ex", line: 9]},
        {Oban.Queue.Executor, :perform_inline, 1, [file: ~c"lib/oban/queue/executor.ex", line: 168]},
        {Oban.Queue.Executor, :perform_inline, 1, [file: ~c"lib/oban/queue/executor.ex", line: 156]},
        {Oban.Queue.Executor, :call, 1, [file: ~c"lib/oban/queue/executor.ex", line: 79]},
        {Task.Supervised, :invoke_mfa, 2, [file: ~c"lib/task/supervised.ex", line: 90]},
        {Task.Supervised, :reply, 5, [file: ~c"lib/task/supervised.ex", line: 35]},
        {:proc_lib, :init_p_do_apply, 3, [file: ~c"proc_lib.erl", line: 249]}
      ],
      state: :failure,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :job, :exception],
    measurements: %{duration: 24_532_300, queue_time: 41_669_912_000},
    metadata: %{
      args: %{"sleep_time" => 662},
      attempt: 1,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      error: %{
        __exception__: true,
        __struct__: ArithmeticError,
        message: "bad argument in arithmetic expression"
      },
      id: 197_067,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "secret",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 662},
        attempt: 1,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {18633, 6},
          minute: 8,
          month: 2,
          second: 19,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "m8icetgo"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [],
        id: 197_067,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {348_721, 6},
          minute: 7,
          month: 2,
          second: 37,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {348_721, 6},
          minute: 7,
          month: 2,
          second: 37,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      kind: :error,
      max_attempts: 20,
      prefix: "secret",
      queue: "default",
      stacktrace: [
        {WebApp.Jobs.DefaultWorker, :perform, 1, [file: ~c"lib/web_app/jobs/default_worker.ex", line: 9]},
        {Oban.Queue.Executor, :perform_inline, 1, [file: ~c"lib/oban/queue/executor.ex", line: 168]},
        {Oban.Queue.Executor, :perform_inline, 1, [file: ~c"lib/oban/queue/executor.ex", line: 156]},
        {Oban.Queue.Executor, :call, 1, [file: ~c"lib/oban/queue/executor.ex", line: 79]},
        {Task.Supervised, :invoke_mfa, 2, [file: ~c"lib/task/supervised.ex", line: 90]},
        {Task.Supervised, :reply, 5, [file: ~c"lib/task/supervised.ex", line: 35]},
        {:proc_lib, :init_p_do_apply, 3, [file: ~c"proc_lib.erl", line: 249]}
      ],
      state: :failure,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :job, :exception],
    measurements: %{duration: 23_613_700, queue_time: 41_579_575_000},
    metadata: %{
      args: %{"sleep_time" => 1493},
      attempt: 1,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      error: %{
        __exception__: true,
        __struct__: ArithmeticError,
        message: "bad argument in arithmetic expression"
      },
      id: 197_073,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "secret",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 1493},
        attempt: 1,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {18633, 6},
          minute: 8,
          month: 2,
          second: 19,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "m8icetgo"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [],
        id: 197_073,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {439_058, 6},
          minute: 7,
          month: 2,
          second: 37,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {439_058, 6},
          minute: 7,
          month: 2,
          second: 37,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      kind: :error,
      max_attempts: 20,
      prefix: "secret",
      queue: "default",
      stacktrace: [
        {WebApp.Jobs.DefaultWorker, :perform, 1, [file: ~c"lib/web_app/jobs/default_worker.ex", line: 9]},
        {Oban.Queue.Executor, :perform_inline, 1, [file: ~c"lib/oban/queue/executor.ex", line: 168]},
        {Oban.Queue.Executor, :perform_inline, 1, [file: ~c"lib/oban/queue/executor.ex", line: 156]},
        {Oban.Queue.Executor, :call, 1, [file: ~c"lib/oban/queue/executor.ex", line: 79]},
        {Task.Supervised, :invoke_mfa, 2, [file: ~c"lib/task/supervised.ex", line: 90]},
        {Task.Supervised, :reply, 5, [file: ~c"lib/task/supervised.ex", line: 35]},
        {:proc_lib, :init_p_do_apply, 3, [file: ~c"proc_lib.erl", line: 249]}
      ],
      state: :failure,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 11_048_100},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "default"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 8_746_400},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "default"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 8_793_900},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 3,
      queue: "default"
    }
  },
  %{
    event: [:oban, :job, :exception],
    measurements: %{duration: 194_800, queue_time: 36_491_971_000},
    metadata: %{
      args: %{"sleep_time" => 3548},
      attempt: 2,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      error: %{
        __exception__: true,
        __struct__: ArithmeticError,
        message: "bad argument in arithmetic expression"
      },
      id: 196_725,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "secret",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 3548},
        attempt: 2,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {138_461, 6},
          minute: 8,
          month: 2,
          second: 19,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "m8icetgo"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [
          %{
            "at" => "2021-02-16T05:07:24.646524Z",
            "attempt" => 1,
            "error" =>
              "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
          }
        ],
        id: 196_725,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {868_780, 6},
          minute: 7,
          month: 2,
          second: 22,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {646_490, 6},
          minute: 7,
          month: 2,
          second: 42,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      kind: :error,
      max_attempts: 20,
      prefix: "secret",
      queue: "default",
      stacktrace: [
        {WebApp.Jobs.DefaultWorker, :perform, 1, [file: ~c"lib/web_app/jobs/default_worker.ex", line: 9]},
        {Oban.Queue.Executor, :perform_inline, 1, [file: ~c"lib/oban/queue/executor.ex", line: 168]},
        {Oban.Queue.Executor, :perform_inline, 1, [file: ~c"lib/oban/queue/executor.ex", line: 156]},
        {Oban.Queue.Executor, :call, 1, [file: ~c"lib/oban/queue/executor.ex", line: 79]},
        {Task.Supervised, :invoke_mfa, 2, [file: ~c"lib/task/supervised.ex", line: 90]},
        {Task.Supervised, :reply, 5, [file: ~c"lib/task/supervised.ex", line: 35]},
        {:proc_lib, :init_p_do_apply, 3, [file: ~c"proc_lib.erl", line: 249]}
      ],
      state: :failure,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :job, :exception],
    measurements: %{duration: 962_300, queue_time: 36_091_882_000},
    metadata: %{
      args: %{"sleep_time" => 1956},
      attempt: 2,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      error: %{
        __exception__: true,
        __struct__: ArithmeticError,
        message: "bad argument in arithmetic expression"
      },
      id: 196_747,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "secret",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 1956},
        attempt: 2,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {138_461, 6},
          minute: 8,
          month: 2,
          second: 19,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "m8icetgo"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [
          %{
            "at" => "2021-02-16T05:07:25.046611Z",
            "attempt" => 1,
            "error" =>
              "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
          }
        ],
        id: 196_747,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {383_674, 6},
          minute: 7,
          month: 2,
          second: 24,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {46579, 6},
          minute: 7,
          month: 2,
          second: 43,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      kind: :error,
      max_attempts: 20,
      prefix: "secret",
      queue: "default",
      stacktrace: [
        {WebApp.Jobs.DefaultWorker, :perform, 1, [file: ~c"lib/web_app/jobs/default_worker.ex", line: 9]},
        {Oban.Queue.Executor, :perform_inline, 1, [file: ~c"lib/oban/queue/executor.ex", line: 168]},
        {Oban.Queue.Executor, :perform_inline, 1, [file: ~c"lib/oban/queue/executor.ex", line: 156]},
        {Oban.Queue.Executor, :call, 1, [file: ~c"lib/oban/queue/executor.ex", line: 79]},
        {Task.Supervised, :invoke_mfa, 2, [file: ~c"lib/task/supervised.ex", line: 90]},
        {Task.Supervised, :reply, 5, [file: ~c"lib/task/supervised.ex", line: 35]},
        {:proc_lib, :init_p_do_apply, 3, [file: ~c"proc_lib.erl", line: 249]}
      ],
      state: :failure,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 7_211_800},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 2,
      queue: "default"
    }
  },
  %{
    event: [:oban, :job, :stop],
    measurements: %{duration: 704_372_700, queue_time: 40_336_629_000},
    metadata: %{
      args: %{"sleep_time" => 671},
      attempt: 1,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      id: 196_298,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "public",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 671},
        attempt: 1,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {968_847, 6},
          minute: 8,
          month: 2,
          second: 18,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "4gtct002"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [],
        id: 196_298,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {632_218, 6},
          minute: 7,
          month: 2,
          second: 38,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {632_218, 6},
          minute: 7,
          month: 2,
          second: 38,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      max_attempts: 20,
      prefix: "public",
      queue: "default",
      state: :success,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 6_226_700},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "default"
    }
  },
  %{
    event: [:oban, :job, :stop],
    measurements: %{duration: 1_060_075_100, queue_time: 40_119_789_000},
    metadata: %{
      args: %{"sleep_time" => 954},
      attempt: 1,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      id: 196_302,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "public",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 954},
        attempt: 1,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {968_847, 6},
          minute: 8,
          month: 2,
          second: 18,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "4gtct002"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [],
        id: 196_302,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {849_058, 6},
          minute: 7,
          month: 2,
          second: 38,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {849_058, 6},
          minute: 7,
          month: 2,
          second: 38,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      max_attempts: 20,
      prefix: "public",
      queue: "default",
      state: :success,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 4_273_000},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "default"
    }
  },
  %{
    event: [:oban, :job, :stop],
    measurements: %{duration: 574_853_900, queue_time: 38_260_932_000},
    metadata: %{
      args: %{"sleep_time" => 547},
      attempt: 2,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      id: 195_905,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "public",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 547},
        attempt: 2,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {754_624, 6},
          minute: 8,
          month: 2,
          second: 19,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "4gtct002"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [
          %{
            "at" => "2021-02-16T05:07:24.493719Z",
            "attempt" => 1,
            "error" =>
              "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
          }
        ],
        id: 195_905,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {758_824, 6},
          minute: 7,
          month: 2,
          second: 22,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {493_692, 6},
          minute: 7,
          month: 2,
          second: 41,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      max_attempts: 20,
      prefix: "public",
      queue: "default",
      state: :success,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :job, :stop],
    measurements: %{duration: 1_296_862_600, queue_time: 41_699_882_000},
    metadata: %{
      args: %{"sleep_time" => 1189},
      attempt: 1,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      id: 197_063,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "secret",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 1189},
        attempt: 1,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {18633, 6},
          minute: 8,
          month: 2,
          second: 19,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "m8icetgo"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [],
        id: 197_063,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {318_751, 6},
          minute: 7,
          month: 2,
          second: 37,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {318_751, 6},
          minute: 7,
          month: 2,
          second: 37,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      max_attempts: 20,
      prefix: "secret",
      queue: "default",
      state: :success,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :job, :stop],
    measurements: %{duration: 1_297_774_500, queue_time: 41_612_762_000},
    metadata: %{
      args: %{"sleep_time" => 1239},
      attempt: 1,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      id: 197_070,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "secret",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 1239},
        attempt: 1,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {18633, 6},
          minute: 8,
          month: 2,
          second: 19,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "m8icetgo"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [],
        id: 197_070,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {405_871, 6},
          minute: 7,
          month: 2,
          second: 37,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {405_871, 6},
          minute: 7,
          month: 2,
          second: 37,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      max_attempts: 20,
      prefix: "secret",
      queue: "default",
      state: :success,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 9_011_400},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "default"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 10_158_600},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "default"
    }
  },
  %{
    event: [:oban, :job, :exception],
    measurements: %{duration: 253_100, queue_time: 36_308_161_000},
    metadata: %{
      args: %{"sleep_time" => 1758},
      attempt: 2,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      error: %{
        __exception__: true,
        __struct__: ArithmeticError,
        message: "bad argument in arithmetic expression"
      },
      id: 195_969,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "public",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 1758},
        attempt: 2,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {356_730, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "4gtct002"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [
          %{
            "at" => "2021-02-16T05:07:27.048595Z",
            "attempt" => 1,
            "error" =>
              "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
          }
        ],
        id: 195_969,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {777_509, 6},
          minute: 7,
          month: 2,
          second: 24,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {48569, 6},
          minute: 7,
          month: 2,
          second: 44,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      kind: :error,
      max_attempts: 20,
      prefix: "public",
      queue: "default",
      stacktrace: [
        {WebApp.Jobs.DefaultWorker, :perform, 1, [file: ~c"lib/web_app/jobs/default_worker.ex", line: 9]},
        {Oban.Queue.Executor, :perform_inline, 1, [file: ~c"lib/oban/queue/executor.ex", line: 168]},
        {Oban.Queue.Executor, :perform_inline, 1, [file: ~c"lib/oban/queue/executor.ex", line: 156]},
        {Oban.Queue.Executor, :call, 1, [file: ~c"lib/oban/queue/executor.ex", line: 79]},
        {Task.Supervised, :invoke_mfa, 2, [file: ~c"lib/task/supervised.ex", line: 90]},
        {Task.Supervised, :reply, 5, [file: ~c"lib/task/supervised.ex", line: 35]},
        {:proc_lib, :init_p_do_apply, 3, [file: ~c"proc_lib.erl", line: 249]}
      ],
      state: :failure,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 4_164_000},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "default"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 5_382_100},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "default"
    }
  },
  %{
    event: [:oban, :job, :stop],
    measurements: %{duration: 325_375_800, queue_time: 34_186_438_000},
    metadata: %{
      args: %{"sleep_time" => 290},
      attempt: 2,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      id: 196_841,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "secret",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 290},
        attempt: 2,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {372_153, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "m8icetgo"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [
          %{
            "at" => "2021-02-16T05:07:29.185768Z",
            "attempt" => 1,
            "error" =>
              "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
          }
        ],
        id: 196_841,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {364_118, 6},
          minute: 7,
          month: 2,
          second: 26,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {185_715, 6},
          minute: 7,
          month: 2,
          second: 46,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      max_attempts: 20,
      prefix: "secret",
      queue: "default",
      state: :success,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 4_907_300},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "default"
    }
  },
  %{
    event: [:oban, :job, :stop],
    measurements: %{duration: 1_776_009_200, queue_time: 40_236_246_000},
    metadata: %{
      args: %{"sleep_time" => 1744},
      attempt: 1,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      id: 196_300,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "public",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 1744},
        attempt: 1,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {968_847, 6},
          minute: 8,
          month: 2,
          second: 18,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "4gtct002"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [],
        id: 196_300,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {732_601, 6},
          minute: 7,
          month: 2,
          second: 38,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {732_601, 6},
          minute: 7,
          month: 2,
          second: 38,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      max_attempts: 20,
      prefix: "public",
      queue: "default",
      state: :success,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 5_572_200},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "default"
    }
  },
  %{
    event: [:oban, :job, :exception],
    measurements: %{duration: 274_700, queue_time: 34_231_033_000},
    metadata: %{
      args: %{"sleep_time" => 1386},
      attempt: 2,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      error: %{
        __exception__: true,
        __struct__: ArithmeticError,
        message: "bad argument in arithmetic expression"
      },
      id: 196_077,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "public",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 1386},
        attempt: 2,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {825_238, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "4gtct002"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [
          %{
            "at" => "2021-02-16T05:07:30.594231Z",
            "attempt" => 1,
            "error" =>
              "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
          }
        ],
        id: 196_077,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {887_344, 6},
          minute: 7,
          month: 2,
          second: 27,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {594_205, 6},
          minute: 7,
          month: 2,
          second: 46,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      kind: :error,
      max_attempts: 20,
      prefix: "public",
      queue: "default",
      stacktrace: [
        {WebApp.Jobs.DefaultWorker, :perform, 1, [file: ~c"lib/web_app/jobs/default_worker.ex", line: 9]},
        {Oban.Queue.Executor, :perform_inline, 1, [file: ~c"lib/oban/queue/executor.ex", line: 168]},
        {Oban.Queue.Executor, :perform_inline, 1, [file: ~c"lib/oban/queue/executor.ex", line: 156]},
        {Oban.Queue.Executor, :call, 1, [file: ~c"lib/oban/queue/executor.ex", line: 79]},
        {Task.Supervised, :invoke_mfa, 2, [file: ~c"lib/task/supervised.ex", line: 90]},
        {Task.Supervised, :reply, 5, [file: ~c"lib/task/supervised.ex", line: 35]},
        {:proc_lib, :init_p_do_apply, 3, [file: ~c"proc_lib.erl", line: 249]}
      ],
      state: :failure,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 9_055_100},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "default"
    }
  },
  %{
    event: [:oban, :job, :stop],
    measurements: %{duration: 1_769_361_100, queue_time: 37_916_462_000},
    metadata: %{
      args: %{"sleep_time" => 1743},
      attempt: 2,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      id: 195_872,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "public",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 1743},
        attempt: 2,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {125_231, 6},
          minute: 8,
          month: 2,
          second: 19,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "4gtct002"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [
          %{
            "at" => "2021-02-16T05:07:23.208799Z",
            "attempt" => 1,
            "error" =>
              "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
          }
        ],
        id: 195_872,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {575_133, 6},
          minute: 7,
          month: 2,
          second: 21,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {208_769, 6},
          minute: 7,
          month: 2,
          second: 41,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      max_attempts: 20,
      prefix: "public",
      queue: "default",
      state: :success,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 22_482_800},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "default"
    }
  },
  %{
    event: [:oban, :job, :stop],
    measurements: %{duration: 1_795_129_100, queue_time: 38_042_359_000},
    metadata: %{
      args: %{"sleep_time" => 1693},
      attempt: 2,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      id: 196_753,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "secret",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 1693},
        attempt: 2,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {121_163, 6},
          minute: 8,
          month: 2,
          second: 19,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "m8icetgo"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [
          %{
            "at" => "2021-02-16T05:07:25.078837Z",
            "attempt" => 1,
            "error" =>
              "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
          }
        ],
        id: 196_753,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {421_687, 6},
          minute: 7,
          month: 2,
          second: 24,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {78804, 6},
          minute: 7,
          month: 2,
          second: 41,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      max_attempts: 20,
      prefix: "secret",
      queue: "default",
      state: :success,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 5_025_300},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "default"
    }
  },
  %{
    event: [:oban, :job, :stop],
    measurements: %{duration: 1_857_098_200, queue_time: 40_538_566_000},
    metadata: %{
      args: %{"sleep_time" => 1752},
      attempt: 1,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      id: 196_297,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "public",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 1752},
        attempt: 1,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {968_847, 6},
          minute: 8,
          month: 2,
          second: 18,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "4gtct002"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [],
        id: 196_297,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {430_281, 6},
          minute: 7,
          month: 2,
          second: 38,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {430_281, 6},
          minute: 7,
          month: 2,
          second: 38,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      max_attempts: 20,
      prefix: "public",
      queue: "default",
      state: :success,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 13_973_700},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "default"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 9_452_200},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 0,
      queue: "events"
    }
  },
  %{
    event: [:oban, :job, :exception],
    measurements: %{duration: 353_800, queue_time: 33_339_305_000},
    metadata: %{
      args: %{"sleep_time" => 4811},
      attempt: 2,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      error: %{
        __exception__: true,
        __struct__: ArithmeticError,
        message: "bad argument in arithmetic expression"
      },
      id: 196_873,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "secret",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 4811},
        attempt: 2,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {898_594, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "m8icetgo"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [
          %{
            "at" => "2021-02-16T05:07:30.559321Z",
            "attempt" => 1,
            "error" =>
              "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
          }
        ],
        id: 196_873,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {748_319, 6},
          minute: 7,
          month: 2,
          second: 27,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {559_289, 6},
          minute: 7,
          month: 2,
          second: 47,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      kind: :error,
      max_attempts: 20,
      prefix: "secret",
      queue: "default",
      stacktrace: [
        {WebApp.Jobs.DefaultWorker, :perform, 1, [file: ~c"lib/web_app/jobs/default_worker.ex", line: 9]},
        {Oban.Queue.Executor, :perform_inline, 1, [file: ~c"lib/oban/queue/executor.ex", line: 168]},
        {Oban.Queue.Executor, :perform_inline, 1, [file: ~c"lib/oban/queue/executor.ex", line: 156]},
        {Oban.Queue.Executor, :call, 1, [file: ~c"lib/oban/queue/executor.ex", line: 79]},
        {Task.Supervised, :invoke_mfa, 2, [file: ~c"lib/task/supervised.ex", line: 90]},
        {Task.Supervised, :reply, 5, [file: ~c"lib/task/supervised.ex", line: 35]},
        {:proc_lib, :init_p_do_apply, 3, [file: ~c"proc_lib.erl", line: 249]}
      ],
      state: :failure,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 24_252_100},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "media"
    }
  },
  %{
    event: [:oban, :job, :stop],
    measurements: %{duration: 790_759_700, queue_time: 37_712_882_000},
    metadata: %{
      args: %{"sleep_time" => 756},
      attempt: 2,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      id: 195_948,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "public",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 756},
        attempt: 2,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {107_013, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "4gtct002"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [
          %{
            "at" => "2021-02-16T05:07:26.394157Z",
            "attempt" => 1,
            "error" =>
              "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
          }
        ],
        id: 195_948,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {505_336, 6},
          minute: 7,
          month: 2,
          second: 24,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {394_131, 6},
          minute: 7,
          month: 2,
          second: 42,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      max_attempts: 20,
      prefix: "public",
      queue: "default",
      state: :success,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 18_930_800},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "events"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 20_863_500},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "default"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 18_898_900},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "media"
    }
  },
  %{
    event: [:oban, :job, :stop],
    measurements: %{duration: 17_063_600, queue_time: 59_586_000},
    metadata: %{
      args: %{"sleep_time" => 10},
      attempt: 1,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      id: 197_105,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "secret",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 10},
        attempt: 1,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {910_931, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "media", "064jflfo"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [],
        id: 197_105,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {851_345, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "media",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {851_345, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.MediaWorker"
      },
      max_attempts: 20,
      prefix: "secret",
      queue: "media",
      state: :success,
      tags: [],
      worker: "WebApp.Jobs.MediaWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 29_036_200},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "default"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 6_432_400},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 0,
      queue: "media"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 22_932_600},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "events"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 11_112_700},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "media"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 15_203_200},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "media"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 14_884_100},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "events"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 8_128_200},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "media"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 19_740_500},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "events"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 19_915_800},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 0,
      queue: "events"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 13_547_400},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "media"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 12_703_800},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "media"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 15_404_800},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 0,
      queue: "events"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 15_749_400},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "events"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 14_680_300},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 0,
      queue: "media"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 15_686_400},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "media"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 16_956_000},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "events"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 9_322_600},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "media"
    }
  },
  %{
    event: [:oban, :job, :stop],
    measurements: %{duration: 159_884_800, queue_time: 32_932_028_000},
    metadata: %{
      args: %{"sleep_time" => 108},
      attempt: 2,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      id: 196_065,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "public",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 108},
        attempt: 2,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {911_484, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "4gtct002"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [
          %{
            "at" => "2021-02-16T05:07:29.979482Z",
            "attempt" => 1,
            "error" =>
              "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
          }
        ],
        id: 196_065,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {777_210, 6},
          minute: 7,
          month: 2,
          second: 27,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {979_456, 6},
          minute: 7,
          month: 2,
          second: 47,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      max_attempts: 20,
      prefix: "public",
      queue: "default",
      state: :success,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 18_060_400},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 0,
      queue: "events"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 15_909_100},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "events"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 25_146_500},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "default"
    }
  },
  %{
    event: [:oban, :job, :stop],
    measurements: %{duration: 152_919_700, queue_time: 89_249_000},
    metadata: %{
      args: %{"sleep_time" => 152},
      attempt: 1,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      id: 196_341,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "public",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 152},
        attempt: 1,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {940_882, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "media", "b3rs7hsf"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [],
        id: 196_341,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {851_633, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "media",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {851_633, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.MediaWorker"
      },
      max_attempts: 20,
      prefix: "public",
      queue: "media",
      state: :success,
      tags: [],
      worker: "WebApp.Jobs.MediaWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 17_826_200},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "media"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 27_311_100},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 0,
      queue: "media"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 9_950_000},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 0,
      queue: "events"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 6_398_300},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 0,
      queue: "media"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 13_790_900},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 0,
      queue: "events"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 21_705_400},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 0,
      queue: "events"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 21_630_400},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 0,
      queue: "media"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 14_517_900},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 2,
      queue: "events"
    }
  },
  %{
    event: [:oban, :job, :stop],
    measurements: %{duration: 108_777_600, queue_time: 43_516_000},
    metadata: %{
      args: %{"sleep_time" => 106},
      attempt: 1,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      id: 196_349,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "public",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 106},
        attempt: 1,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {53755, 6},
          minute: 8,
          month: 2,
          second: 21,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "events", "rr5nfukr"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [],
        id: 196_349,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {10239, 6},
          minute: 8,
          month: 2,
          second: 21,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "events",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {10239, 6},
          minute: 8,
          month: 2,
          second: 21,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.EventWorker"
      },
      max_attempts: 20,
      prefix: "public",
      queue: "events",
      state: :success,
      tags: [],
      worker: "WebApp.Jobs.EventWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 15_641_800},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 0,
      queue: "media"
    }
  },
  %{
    event: [:oban, :job, :stop],
    measurements: %{duration: 144_681_900, queue_time: 25_111_000},
    metadata: %{
      args: %{"sleep_time" => 144},
      attempt: 1,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      id: 196_348,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "public",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 144},
        attempt: 1,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {35471, 6},
          minute: 8,
          month: 2,
          second: 21,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "media", "b3rs7hsf"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [],
        id: 196_348,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {10360, 6},
          minute: 8,
          month: 2,
          second: 21,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "media",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {10360, 6},
          minute: 8,
          month: 2,
          second: 21,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.MediaWorker"
      },
      max_attempts: 20,
      prefix: "public",
      queue: "media",
      state: :success,
      tags: [],
      worker: "WebApp.Jobs.MediaWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 14_995_300},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "events"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 16_892_100},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 0,
      queue: "media"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 29_680_900},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "events"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 29_251_100},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "media"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 6_741_500},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 0,
      queue: "events"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 9_067_000},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 2,
      queue: "media"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 3_969_000},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 0,
      queue: "media"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 2_639_000},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 0,
      queue: "media"
    }
  },
  %{
    event: [:oban, :job, :stop],
    measurements: %{duration: 364_931_700, queue_time: 23_371_000},
    metadata: %{
      args: %{"sleep_time" => 362},
      attempt: 1,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      id: 196_344,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "public",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 362},
        attempt: 1,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {965_576, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "media", "b3rs7hsf"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [],
        id: 196_344,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {942_205, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "media",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {942_205, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.MediaWorker"
      },
      max_attempts: 20,
      prefix: "public",
      queue: "media",
      state: :success,
      tags: [],
      worker: "WebApp.Jobs.MediaWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 3_174_100},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "public",
        queues: [default: [limit: 5], events: [limit: 25], media: [limit: 10]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 0,
      queue: "media"
    }
  },
  %{
    event: [:oban, :job, :stop],
    measurements: %{duration: 690_872_900, queue_time: 33_916_963_000},
    metadata: %{
      args: %{"sleep_time" => 635},
      attempt: 3,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      id: 196_386,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "secret",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 635},
        attempt: 3,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {705_797, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "m8icetgo"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [
          %{
            "at" => "2021-02-16T05:07:09.571623Z",
            "attempt" => 1,
            "error" =>
              "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
          },
          %{
            "at" => "2021-02-16T05:07:29.788861Z",
            "attempt" => 2,
            "error" =>
              "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
          }
        ],
        id: 196_386,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {411_859, 6},
          minute: 6,
          month: 2,
          second: 33,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {788_834, 6},
          minute: 7,
          month: 2,
          second: 46,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      max_attempts: 20,
      prefix: "secret",
      queue: "default",
      state: :success,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 18_288_600},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "default"
    }
  },
  %{
    event: [:oban, :job, :stop],
    measurements: %{duration: 2_408_819_600, queue_time: 41_569_925_000},
    metadata: %{
      args: %{"sleep_time" => 2353},
      attempt: 1,
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      id: 197_076,
      job: %{
        __meta__: %{
          __struct__: Ecto.Schema.Metadata,
          context: nil,
          prefix: "secret",
          schema: Oban.Job,
          source: "oban_jobs",
          state: :loaded
        },
        __struct__: Oban.Job,
        args: %{"sleep_time" => 2353},
        attempt: 1,
        attempted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {18633, 6},
          minute: 8,
          month: 2,
          second: 19,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        attempted_by: ["a000037d44aa", "default", "m8icetgo"],
        cancelled_at: nil,
        completed_at: nil,
        discarded_at: nil,
        errors: [],
        id: 197_076,
        inserted_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {448_708, 6},
          minute: 7,
          month: 2,
          second: 37,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        max_attempts: 20,
        meta: %{},
        priority: 0,
        queue: "default",
        replace_args: nil,
        scheduled_at: %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {448_708, 6},
          minute: 7,
          month: 2,
          second: 37,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        state: "executing",
        tags: [],
        unique: nil,
        unsaved_error: nil,
        worker: "WebApp.Jobs.DefaultWorker"
      },
      max_attempts: 20,
      prefix: "secret",
      queue: "default",
      state: :success,
      tags: [],
      worker: "WebApp.Jobs.DefaultWorker"
    }
  },
  %{
    event: [:oban, :producer, :stop],
    measurements: %{duration: 66_876_100},
    metadata: %{
      conf: %{
        __struct__: Oban.Config,
        circuit_backoff: 30000,
        dispatch_cooldown: 5,
        get_dynamic_repo: nil,
        log: false,
        name: Oban.SuperSecret,
        node: "a000037d44aa",
        plugins: [Oban.Plugins.Pruner, Oban.Plugins.Stager],
        prefix: "secret",
        queues: [default: [limit: 10], events: [limit: 50], media: [limit: 20]],
        repo: WebApp.Repo,
        shutdown_grace_period: 15000
      },
      dispatched_count: 1,
      queue: "default"
    }
  }
]
