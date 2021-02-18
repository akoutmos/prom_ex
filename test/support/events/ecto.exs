[
  %{
    event: [:ecto, :repo, :init],
    measurements: %{system_time: 1_613_452_097_376_417_400},
    metadata: %{
      opts: [
        telemetry_prefix: [:web_app, :repo],
        otp_app: :web_app,
        timeout: 15000,
        username: "postgres",
        password: "postgres",
        database: "web_app_dev",
        hostname: "postgres",
        show_sensitive_data_on_connection_error: true,
        pool_size: 10
      ],
      repo: WebApp.Repo
    }
  },
  %{
    event: [:ecto, :repo, :init],
    measurements: %{system_time: 1_613_452_097_611_869_700},
    metadata: %{
      opts: [
        telemetry_prefix: [:web_app, :repo2],
        otp_app: :web_app,
        timeout: 15000,
        username: "postgres",
        password: "postgres",
        database: "web_app_dev",
        hostname: "postgres",
        show_sensitive_data_on_connection_error: true,
        pool_size: 10
      ],
      repo: WebApp.Repo2
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 1_073_426_700,
      query_time: 4_975_900,
      queue_time: 83400,
      total_time: 5_059_300
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 119,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 1_118_893_300,
      query_time: 2_589_600,
      queue_time: 100_300,
      total_time: 2_689_900
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 126,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 84200,
      query_time: 25_120_100,
      total_time: 25_204_300
    },
    metadata: %{
      options: [],
      params: [
        "executing",
        %{
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
        ["a000037d44aa", "default", "4gtct002"],
        1,
        "default",
        5
      ],
      query:
        "UPDATE \"public\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"attempted_at\" = $2, \"attempted_by\" = $3, \"attempt\" = o0.\"attempt\" + $4 WHERE (o0.\"id\" IN (SELECT so0.\"id\" FROM \"public\".\"oban_jobs\" AS so0 WHERE (so0.\"state\" = 'available') AND (so0.\"queue\" = $5) ORDER BY so0.\"priority\", so0.\"scheduled_at\", so0.\"id\" LIMIT $6 FOR UPDATE SKIP LOCKED)) RETURNING o0.\"id\", o0.\"state\", o0.\"queue\", o0.\"worker\", o0.\"args\", o0.\"errors\", o0.\"tags\", o0.\"attempt\", o0.\"attempted_by\", o0.\"max_attempts\", o0.\"meta\", o0.\"priority\", o0.\"attempted_at\", o0.\"completed_at\", o0.\"discarded_at\", o0.\"cancelled_at\", o0.\"inserted_at\", o0.\"scheduled_at\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: [
             "id",
             "state",
             "queue",
             "worker",
             "args",
             "errors",
             "tags",
             "attempt",
             "attempted_by",
             "max_attempts",
             "meta",
             "priority",
             "attempted_at",
             "completed_at",
             "discarded_at",
             "cancelled_at",
             "inserted_at",
             "scheduled_at"
           ],
           command: :update,
           connection_id: 119,
           messages: [],
           num_rows: 5,
           rows: [
             [
               195_899,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 1958},
               [
                 %{
                   "at" => "2021-02-16T05:07:24.221577Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "4gtct002"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {968_847, 6},
                 minute: 8,
                 month: 2,
                 second: 18,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {611_691, 6},
                 minute: 7,
                 month: 2,
                 second: 22,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {221_549, 6},
                 minute: 7,
                 month: 2,
                 second: 39,
                 year: 2021
               }
             ],
             [
               196_302,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 954},
               [],
               [],
               1,
               ["a000037d44aa", "default", "4gtct002"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {968_847, 6},
                 minute: 8,
                 month: 2,
                 second: 18,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {849_058, 6},
                 minute: 7,
                 month: 2,
                 second: 38,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {849_058, 6},
                 minute: 7,
                 month: 2,
                 second: 38,
                 year: 2021
               }
             ],
             [
               196_300,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 1744},
               [],
               [],
               1,
               ["a000037d44aa", "default", "4gtct002"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {968_847, 6},
                 minute: 8,
                 month: 2,
                 second: 18,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {732_601, 6},
                 minute: 7,
                 month: 2,
                 second: 38,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {732_601, 6},
                 minute: 7,
                 month: 2,
                 second: 38,
                 year: 2021
               }
             ],
             [
               196_298,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 671},
               [],
               [],
               1,
               ["a000037d44aa", "default", "4gtct002"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {968_847, 6},
                 minute: 8,
                 month: 2,
                 second: 18,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {632_218, 6},
                 minute: 7,
                 month: 2,
                 second: 38,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {632_218, 6},
                 minute: 7,
                 month: 2,
                 second: 38,
                 year: 2021
               }
             ],
             [
               196_297,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 1752},
               [],
               [],
               1,
               ["a000037d44aa", "default", "4gtct002"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {968_847, 6},
                 minute: 8,
                 month: 2,
                 second: 18,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {430_281, 6},
                 minute: 7,
                 month: 2,
                 second: 38,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {430_281, 6},
                 minute: 7,
                 month: 2,
                 second: 38,
                 year: 2021
               }
             ]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 11400,
      query_time: 23_378_000,
      total_time: 23_389_400
    },
    metadata: %{
      options: [],
      params: [
        "executing",
        %{
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
        ["a000037d44aa", "default", "m8icetgo"],
        1,
        "default",
        10
      ],
      query:
        "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"attempted_at\" = $2, \"attempted_by\" = $3, \"attempt\" = o0.\"attempt\" + $4 WHERE (o0.\"id\" IN (SELECT so0.\"id\" FROM \"secret\".\"oban_jobs\" AS so0 WHERE (so0.\"state\" = 'available') AND (so0.\"queue\" = $5) ORDER BY so0.\"priority\", so0.\"scheduled_at\", so0.\"id\" LIMIT $6 FOR UPDATE SKIP LOCKED)) RETURNING o0.\"id\", o0.\"state\", o0.\"queue\", o0.\"worker\", o0.\"args\", o0.\"errors\", o0.\"tags\", o0.\"attempt\", o0.\"attempted_by\", o0.\"max_attempts\", o0.\"meta\", o0.\"priority\", o0.\"attempted_at\", o0.\"completed_at\", o0.\"discarded_at\", o0.\"cancelled_at\", o0.\"inserted_at\", o0.\"scheduled_at\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: [
             "id",
             "state",
             "queue",
             "worker",
             "args",
             "errors",
             "tags",
             "attempt",
             "attempted_by",
             "max_attempts",
             "meta",
             "priority",
             "attempted_at",
             "completed_at",
             "discarded_at",
             "cancelled_at",
             "inserted_at",
             "scheduled_at"
           ],
           command: :update,
           connection_id: 126,
           messages: [],
           num_rows: 10,
           rows: [
             [
               196_696,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 4688},
               [
                 %{
                   "at" => "2021-02-16T05:07:23.084046Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "m8icetgo"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {18633, 6},
                 minute: 8,
                 month: 2,
                 second: 19,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {543_366, 6},
                 minute: 7,
                 month: 2,
                 second: 22,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {84010, 6},
                 minute: 7,
                 month: 2,
                 second: 38,
                 year: 2021
               }
             ],
             [
               196_700,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 3211},
               [
                 %{
                   "at" => "2021-02-16T05:07:23.096736Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "m8icetgo"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {18633, 6},
                 minute: 8,
                 month: 2,
                 second: 19,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {556_937, 6},
                 minute: 7,
                 month: 2,
                 second: 22,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {96701, 6},
                 minute: 7,
                 month: 2,
                 second: 38,
                 year: 2021
               }
             ],
             [
               197_079,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 1973},
               [],
               [],
               1,
               ["a000037d44aa", "default", "m8icetgo"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {18633, 6},
                 minute: 8,
                 month: 2,
                 second: 19,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {61430, 6},
                 minute: 7,
                 month: 2,
                 second: 38,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {61430, 6},
                 minute: 7,
                 month: 2,
                 second: 38,
                 year: 2021
               }
             ],
             [
               197_067,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 662},
               [],
               [],
               1,
               ["a000037d44aa", "default", "m8icetgo"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {18633, 6},
                 minute: 8,
                 month: 2,
                 second: 19,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {348_721, 6},
                 minute: 7,
                 month: 2,
                 second: 37,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {348_721, 6},
                 minute: 7,
                 month: 2,
                 second: 37,
                 year: 2021
               }
             ],
             [
               197_076,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 2353},
               [],
               [],
               1,
               ["a000037d44aa", "default", "m8icetgo"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {18633, 6},
                 minute: 8,
                 month: 2,
                 second: 19,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {448_708, 6},
                 minute: 7,
                 month: 2,
                 second: 37,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {448_708, 6},
                 minute: 7,
                 month: 2,
                 second: 37,
                 year: 2021
               }
             ],
             [
               197_063,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 1189},
               [],
               [],
               1,
               ["a000037d44aa", "default", "m8icetgo"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {18633, 6},
                 minute: 8,
                 month: 2,
                 second: 19,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {318_751, 6},
                 minute: 7,
                 month: 2,
                 second: 37,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {318_751, 6},
                 minute: 7,
                 month: 2,
                 second: 37,
                 year: 2021
               }
             ],
             [
               197_070,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 1239},
               [],
               [],
               1,
               ["a000037d44aa", "default", "m8icetgo"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {18633, 6},
                 minute: 8,
                 month: 2,
                 second: 19,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {405_871, 6},
                 minute: 7,
                 month: 2,
                 second: 37,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {405_871, 6},
                 minute: 7,
                 month: 2,
                 second: 37,
                 year: 2021
               }
             ],
             [
               196_624,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 3878},
               [
                 %{
                   "at" => "2021-02-16T05:07:20.026330Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "m8icetgo"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {18633, 6},
                 minute: 8,
                 month: 2,
                 second: 19,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {902_899, 6},
                 minute: 7,
                 month: 2,
                 second: 18,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {26294, 6},
                 minute: 7,
                 month: 2,
                 second: 38,
                 year: 2021
               }
             ],
             [
               196_606,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 3409},
               [
                 %{
                   "at" => "2021-02-16T05:07:19.625117Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "m8icetgo"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {18633, 6},
                 minute: 8,
                 month: 2,
                 second: 19,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {620_046, 6},
                 minute: 7,
                 month: 2,
                 second: 18,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {625_072, 6},
                 minute: 7,
                 month: 2,
                 second: 37,
                 year: 2021
               }
             ],
             [
               197_073,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 1493},
               [],
               [],
               1,
               ["a000037d44aa", "default", "m8icetgo"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {18633, 6},
                 minute: 8,
                 month: 2,
                 second: 19,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {439_058, 6},
                 minute: 7,
                 month: 2,
                 second: 37,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {439_058, 6},
                 minute: 7,
                 month: 2,
                 second: 37,
                 year: 2021
               }
             ]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 1_405_300, total_time: 1_405_300},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 119,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 1_711_600, total_time: 1_711_600},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 126,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 14800,
      idle_time: 1_216_780_300,
      query_time: 2_935_100,
      queue_time: 1_301_400,
      total_time: 4_251_300
    },
    metadata: %{
      options: [],
      params: [
        "retryable",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {107_763, 6},
          minute: 8,
          month: 2,
          second: 36,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        %{
          at: %{
            __struct__: DateTime,
            calendar: Calendar.ISO,
            day: 16,
            hour: 5,
            microsecond: {111_132, 6},
            minute: 8,
            month: 2,
            second: 19,
            std_offset: 0,
            time_zone: "Etc/UTC",
            utc_offset: 0,
            year: 2021,
            zone_abbr: "UTC"
          },
          attempt: 1,
          error:
            "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
        },
        197_079
      ],
      query:
        "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"scheduled_at\" = $2, \"errors\" = array_append(o0.\"errors\", $3) WHERE (o0.\"id\" = $4)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :update,
           connection_id: 121,
           messages: [],
           num_rows: 1,
           rows: nil
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 9200,
      idle_time: 1_216_624_300,
      query_time: 3_857_400,
      queue_time: 3_089_600,
      total_time: 6_956_200
    },
    metadata: %{
      options: [],
      params: [
        "retryable",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {107_784, 6},
          minute: 8,
          month: 2,
          second: 38,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        %{
          at: %{
            __struct__: DateTime,
            calendar: Calendar.ISO,
            day: 16,
            hour: 5,
            microsecond: {111_249, 6},
            minute: 8,
            month: 2,
            second: 19,
            std_offset: 0,
            time_zone: "Etc/UTC",
            utc_offset: 0,
            year: 2021,
            zone_abbr: "UTC"
          },
          attempt: 2,
          error:
            "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
        },
        196_624
      ],
      query:
        "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"scheduled_at\" = $2, \"errors\" = array_append(o0.\"errors\", $3) WHERE (o0.\"id\" = $4)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :update,
           connection_id: 123,
           messages: [],
           num_rows: 1,
           rows: nil
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 12400,
      idle_time: 1_216_613_700,
      query_time: 5_610_800,
      queue_time: 1_641_100,
      total_time: 7_264_300
    },
    metadata: %{
      options: [],
      params: [
        "retryable",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {107_744, 6},
          minute: 8,
          month: 2,
          second: 36,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        %{
          at: %{
            __struct__: DateTime,
            calendar: Calendar.ISO,
            day: 16,
            hour: 5,
            microsecond: {111_188, 6},
            minute: 8,
            month: 2,
            second: 19,
            std_offset: 0,
            time_zone: "Etc/UTC",
            utc_offset: 0,
            year: 2021,
            zone_abbr: "UTC"
          },
          attempt: 2,
          error:
            "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
        },
        195_899
      ],
      query:
        "UPDATE \"public\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"scheduled_at\" = $2, \"errors\" = array_append(o0.\"errors\", $3) WHERE (o0.\"id\" = $4)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :update,
           connection_id: 120,
           messages: [],
           num_rows: 1,
           rows: nil
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 13100,
      idle_time: 1_216_927_100,
      query_time: 2_662_300,
      queue_time: 4_419_900,
      total_time: 7_095_300
    },
    metadata: %{
      options: [],
      params: [
        "retryable",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {107_798, 6},
          minute: 8,
          month: 2,
          second: 34,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        %{
          at: %{
            __struct__: DateTime,
            calendar: Calendar.ISO,
            day: 16,
            hour: 5,
            microsecond: {111_149, 6},
            minute: 8,
            month: 2,
            second: 19,
            std_offset: 0,
            time_zone: "Etc/UTC",
            utc_offset: 0,
            year: 2021,
            zone_abbr: "UTC"
          },
          attempt: 1,
          error:
            "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
        },
        197_067
      ],
      query:
        "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"scheduled_at\" = $2, \"errors\" = array_append(o0.\"errors\", $3) WHERE (o0.\"id\" = $4)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :update,
           connection_id: 122,
           messages: [],
           num_rows: 1,
           rows: nil
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 1_221_250_700,
      query_time: 1_944_500,
      queue_time: 948_200,
      total_time: 2_892_700
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 127,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 16800,
      idle_time: 1_217_027_800,
      query_time: 2_959_800,
      queue_time: 6_709_500,
      total_time: 9_686_100
    },
    metadata: %{
      options: [],
      params: [
        "retryable",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {107_711, 6},
          minute: 8,
          month: 2,
          second: 36,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        %{
          at: %{
            __struct__: DateTime,
            calendar: Calendar.ISO,
            day: 16,
            hour: 5,
            microsecond: {111_105, 6},
            minute: 8,
            month: 2,
            second: 19,
            std_offset: 0,
            time_zone: "Etc/UTC",
            utc_offset: 0,
            year: 2021,
            zone_abbr: "UTC"
          },
          attempt: 1,
          error:
            "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
        },
        197_073
      ],
      query:
        "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"scheduled_at\" = $2, \"errors\" = array_append(o0.\"errors\", $3) WHERE (o0.\"id\" = $4)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :update,
           connection_id: 124,
           messages: [],
           num_rows: 1,
           rows: nil
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 1_225_392_500,
      query_time: 1_247_900,
      queue_time: 99600,
      total_time: 1_347_500
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 125,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 16800,
      query_time: 5_005_900,
      total_time: 5_022_700
    },
    metadata: %{
      options: [],
      params: [
        "executing",
        %{
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
        ["a000037d44aa", "default", "m8icetgo"],
        1,
        "default",
        1
      ],
      query:
        "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"attempted_at\" = $2, \"attempted_by\" = $3, \"attempt\" = o0.\"attempt\" + $4 WHERE (o0.\"id\" IN (SELECT so0.\"id\" FROM \"secret\".\"oban_jobs\" AS so0 WHERE (so0.\"state\" = 'available') AND (so0.\"queue\" = $5) ORDER BY so0.\"priority\", so0.\"scheduled_at\", so0.\"id\" LIMIT $6 FOR UPDATE SKIP LOCKED)) RETURNING o0.\"id\", o0.\"state\", o0.\"queue\", o0.\"worker\", o0.\"args\", o0.\"errors\", o0.\"tags\", o0.\"attempt\", o0.\"attempted_by\", o0.\"max_attempts\", o0.\"meta\", o0.\"priority\", o0.\"attempted_at\", o0.\"completed_at\", o0.\"discarded_at\", o0.\"cancelled_at\", o0.\"inserted_at\", o0.\"scheduled_at\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: [
             "id",
             "state",
             "queue",
             "worker",
             "args",
             "errors",
             "tags",
             "attempt",
             "attempted_by",
             "max_attempts",
             "meta",
             "priority",
             "attempted_at",
             "completed_at",
             "discarded_at",
             "cancelled_at",
             "inserted_at",
             "scheduled_at"
           ],
           command: :update,
           connection_id: 127,
           messages: [],
           num_rows: 1,
           rows: [
             [
               196_753,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 1693},
               [
                 %{
                   "at" => "2021-02-16T05:07:25.078837Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "m8icetgo"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {121_163, 6},
                 minute: 8,
                 month: 2,
                 second: 19,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {421_687, 6},
                 minute: 7,
                 month: 2,
                 second: 24,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {78804, 6},
                 minute: 7,
                 month: 2,
                 second: 41,
                 year: 2021
               }
             ]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 2_315_600, total_time: 2_315_600},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 127,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{decode_time: 8800, query_time: 5_089_100, total_time: 5_097_900},
    metadata: %{
      options: [],
      params: [
        "executing",
        %{
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
        ["a000037d44aa", "default", "4gtct002"],
        1,
        "default",
        1
      ],
      query:
        "UPDATE \"public\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"attempted_at\" = $2, \"attempted_by\" = $3, \"attempt\" = o0.\"attempt\" + $4 WHERE (o0.\"id\" IN (SELECT so0.\"id\" FROM \"public\".\"oban_jobs\" AS so0 WHERE (so0.\"state\" = 'available') AND (so0.\"queue\" = $5) ORDER BY so0.\"priority\", so0.\"scheduled_at\", so0.\"id\" LIMIT $6 FOR UPDATE SKIP LOCKED)) RETURNING o0.\"id\", o0.\"state\", o0.\"queue\", o0.\"worker\", o0.\"args\", o0.\"errors\", o0.\"tags\", o0.\"attempt\", o0.\"attempted_by\", o0.\"max_attempts\", o0.\"meta\", o0.\"priority\", o0.\"attempted_at\", o0.\"completed_at\", o0.\"discarded_at\", o0.\"cancelled_at\", o0.\"inserted_at\", o0.\"scheduled_at\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: [
             "id",
             "state",
             "queue",
             "worker",
             "args",
             "errors",
             "tags",
             "attempt",
             "attempted_by",
             "max_attempts",
             "meta",
             "priority",
             "attempted_at",
             "completed_at",
             "discarded_at",
             "cancelled_at",
             "inserted_at",
             "scheduled_at"
           ],
           command: :update,
           connection_id: 125,
           messages: [],
           num_rows: 1,
           rows: [
             [
               195_872,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 1743},
               [
                 %{
                   "at" => "2021-02-16T05:07:23.208799Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "4gtct002"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {125_231, 6},
                 minute: 8,
                 month: 2,
                 second: 19,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {575_133, 6},
                 minute: 7,
                 month: 2,
                 second: 21,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {208_769, 6},
                 minute: 7,
                 month: 2,
                 second: 41,
                 year: 2021
               }
             ]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 1_721_100, total_time: 1_721_100},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 125,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 1_238_289_800,
      query_time: 273_000,
      queue_time: 85900,
      total_time: 358_900
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 118,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 16700,
      query_time: 4_497_400,
      total_time: 4_514_100
    },
    metadata: %{
      options: [],
      params: [
        "executing",
        %{
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
        ["a000037d44aa", "default", "m8icetgo"],
        1,
        "default",
        3
      ],
      query:
        "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"attempted_at\" = $2, \"attempted_by\" = $3, \"attempt\" = o0.\"attempt\" + $4 WHERE (o0.\"id\" IN (SELECT so0.\"id\" FROM \"secret\".\"oban_jobs\" AS so0 WHERE (so0.\"state\" = 'available') AND (so0.\"queue\" = $5) ORDER BY so0.\"priority\", so0.\"scheduled_at\", so0.\"id\" LIMIT $6 FOR UPDATE SKIP LOCKED)) RETURNING o0.\"id\", o0.\"state\", o0.\"queue\", o0.\"worker\", o0.\"args\", o0.\"errors\", o0.\"tags\", o0.\"attempt\", o0.\"attempted_by\", o0.\"max_attempts\", o0.\"meta\", o0.\"priority\", o0.\"attempted_at\", o0.\"completed_at\", o0.\"discarded_at\", o0.\"cancelled_at\", o0.\"inserted_at\", o0.\"scheduled_at\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: [
             "id",
             "state",
             "queue",
             "worker",
             "args",
             "errors",
             "tags",
             "attempt",
             "attempted_by",
             "max_attempts",
             "meta",
             "priority",
             "attempted_at",
             "completed_at",
             "discarded_at",
             "cancelled_at",
             "inserted_at",
             "scheduled_at"
           ],
           command: :update,
           connection_id: 118,
           messages: [],
           num_rows: 3,
           rows: [
             [
               196_725,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 3548},
               [
                 %{
                   "at" => "2021-02-16T05:07:24.646524Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "m8icetgo"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {138_461, 6},
                 minute: 8,
                 month: 2,
                 second: 19,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {868_780, 6},
                 minute: 7,
                 month: 2,
                 second: 22,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {646_490, 6},
                 minute: 7,
                 month: 2,
                 second: 42,
                 year: 2021
               }
             ],
             [
               196_736,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 4559},
               [
                 %{
                   "at" => "2021-02-16T05:07:24.927651Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "m8icetgo"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {138_461, 6},
                 minute: 8,
                 month: 2,
                 second: 19,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {322_827, 6},
                 minute: 7,
                 month: 2,
                 second: 24,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {927_622, 6},
                 minute: 7,
                 month: 2,
                 second: 41,
                 year: 2021
               }
             ],
             [
               196_747,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 1956},
               [
                 %{
                   "at" => "2021-02-16T05:07:25.046611Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "m8icetgo"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {138_461, 6},
                 minute: 8,
                 month: 2,
                 second: 19,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {383_674, 6},
                 minute: 7,
                 month: 2,
                 second: 24,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {46579, 6},
                 minute: 7,
                 month: 2,
                 second: 43,
                 year: 2021
               }
             ]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 1_367_600, total_time: 1_367_600},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 118,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 14100,
      idle_time: 71_429_700,
      query_time: 2_838_200,
      queue_time: 94500,
      total_time: 2_946_800
    },
    metadata: %{
      options: [],
      params: [
        "retryable",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {145_433, 6},
          minute: 8,
          month: 2,
          second: 36,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        %{
          at: %{
            __struct__: DateTime,
            calendar: Calendar.ISO,
            day: 16,
            hour: 5,
            microsecond: {145_467, 6},
            minute: 8,
            month: 2,
            second: 19,
            std_offset: 0,
            time_zone: "Etc/UTC",
            utc_offset: 0,
            year: 2021,
            zone_abbr: "UTC"
          },
          attempt: 2,
          error:
            "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
        },
        196_725
      ],
      query:
        "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"scheduled_at\" = $2, \"errors\" = array_append(o0.\"errors\", $3) WHERE (o0.\"id\" = $4)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :update,
           connection_id: 119,
           messages: [],
           num_rows: 1,
           rows: nil
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 14200,
      idle_time: 72_637_100,
      query_time: 2_234_900,
      queue_time: 256_600,
      total_time: 2_505_700
    },
    metadata: %{
      options: [],
      params: [
        "retryable",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {147_589, 6},
          minute: 8,
          month: 2,
          second: 37,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        %{
          at: %{
            __struct__: DateTime,
            calendar: Calendar.ISO,
            day: 16,
            hour: 5,
            microsecond: {147_616, 6},
            minute: 8,
            month: 2,
            second: 19,
            std_offset: 0,
            time_zone: "Etc/UTC",
            utc_offset: 0,
            year: 2021,
            zone_abbr: "UTC"
          },
          attempt: 2,
          error:
            "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
        },
        196_747
      ],
      query:
        "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"scheduled_at\" = $2, \"errors\" = array_append(o0.\"errors\", $3) WHERE (o0.\"id\" = $4)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :update,
           connection_id: 126,
           messages: [],
           num_rows: 1,
           rows: nil
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 34_429_500,
      query_time: 231_000,
      queue_time: 203_700,
      total_time: 434_700
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 121,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 33_885_500,
      query_time: 502_700,
      queue_time: 51300,
      total_time: 554_000
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 123,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{decode_time: 15900, query_time: 282_900, total_time: 298_800},
    metadata: %{
      options: [],
      params: [1_149_979_440_289_383_533],
      query: "SELECT pg_try_advisory_xact_lock($1)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: ["pg_try_advisory_xact_lock"],
           command: :select,
           connection_id: 121,
           messages: [],
           num_rows: 1,
           rows: [[true]]
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 13100,
      query_time: 4_520_900,
      total_time: 4_534_000
    },
    metadata: %{
      options: [],
      params: [
        "executing",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {157_153, 6},
          minute: 8,
          month: 2,
          second: 19,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        ["a000037d44aa", "default", "m8icetgo"],
        1,
        "default",
        2
      ],
      query:
        "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"attempted_at\" = $2, \"attempted_by\" = $3, \"attempt\" = o0.\"attempt\" + $4 WHERE (o0.\"id\" IN (SELECT so0.\"id\" FROM \"secret\".\"oban_jobs\" AS so0 WHERE (so0.\"state\" = 'available') AND (so0.\"queue\" = $5) ORDER BY so0.\"priority\", so0.\"scheduled_at\", so0.\"id\" LIMIT $6 FOR UPDATE SKIP LOCKED)) RETURNING o0.\"id\", o0.\"state\", o0.\"queue\", o0.\"worker\", o0.\"args\", o0.\"errors\", o0.\"tags\", o0.\"attempt\", o0.\"attempted_by\", o0.\"max_attempts\", o0.\"meta\", o0.\"priority\", o0.\"attempted_at\", o0.\"completed_at\", o0.\"discarded_at\", o0.\"cancelled_at\", o0.\"inserted_at\", o0.\"scheduled_at\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: [
             "id",
             "state",
             "queue",
             "worker",
             "args",
             "errors",
             "tags",
             "attempt",
             "attempted_by",
             "max_attempts",
             "meta",
             "priority",
             "attempted_at",
             "completed_at",
             "discarded_at",
             "cancelled_at",
             "inserted_at",
             "scheduled_at"
           ],
           command: :update,
           connection_id: 123,
           messages: [],
           num_rows: 2,
           rows: [
             [
               196_800,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 3638},
               [
                 %{
                   "at" => "2021-02-16T05:07:27.026611Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "m8icetgo"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {157_153, 6},
                 minute: 8,
                 month: 2,
                 second: 19,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {6702, 6},
                 minute: 7,
                 month: 2,
                 second: 25,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {26574, 6},
                 minute: 7,
                 month: 2,
                 second: 44,
                 year: 2021
               }
             ],
             [
               196_809,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 4302},
               [
                 %{
                   "at" => "2021-02-16T05:07:27.434694Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "m8icetgo"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {157_153, 6},
                 minute: 8,
                 month: 2,
                 second: 19,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {114_154, 6},
                 minute: 7,
                 month: 2,
                 second: 26,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {434_651, 6},
                 minute: 7,
                 month: 2,
                 second: 43,
                 year: 2021
               }
             ]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 1_346_800, total_time: 1_346_800},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 123,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 16700,
      query_time: 1_471_900,
      total_time: 1_488_600
    },
    metadata: %{
      options: [],
      params: [
        "available",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {162_133, 6},
          minute: 8,
          month: 2,
          second: 19,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        }
      ],
      query:
        "UPDATE \"public\".\"oban_jobs\" AS o0 SET \"state\" = $1 WHERE (o0.\"state\" IN ('scheduled','retryable')) AND (NOT (o0.\"queue\" IS NULL)) AND (o0.\"scheduled_at\" <= $2) RETURNING o0.\"queue\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: ["queue"],
           command: :update,
           connection_id: 121,
           messages: [],
           num_rows: 0,
           rows: []
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{decode_time: 15800, query_time: 752_000, total_time: 767_800},
    metadata: %{
      options: [],
      params: ["public.oban_insert"],
      query:
        "SELECT pg_notify($1, json_build_object('queue', o0.\"queue\")::text) FROM \"public\".\"oban_jobs\" AS o0 WHERE (o0.\"state\" = 'available') AND (NOT (o0.\"queue\" IS NULL))",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: ["pg_notify"],
           command: :select,
           connection_id: 121,
           messages: [],
           num_rows: 36,
           rows: [
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 7_729_000, total_time: 7_729_000},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 121,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 114_526_000,
      query_time: 756_600,
      queue_time: 80000,
      total_time: 836_600
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 120,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{decode_time: 17100, query_time: 691_500, total_time: 708_600},
    metadata: %{
      options: [],
      params: [1_149_979_440_356_993_929],
      query: "SELECT pg_try_advisory_xact_lock($1)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: ["pg_try_advisory_xact_lock"],
           command: :select,
           connection_id: 120,
           messages: [],
           num_rows: 1,
           rows: [[true]]
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 18300,
      query_time: 1_873_800,
      total_time: 1_892_100
    },
    metadata: %{
      options: [],
      params: [
        "available",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {206_128, 6},
          minute: 8,
          month: 2,
          second: 19,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        }
      ],
      query:
        "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1 WHERE (o0.\"state\" IN ('scheduled','retryable')) AND (NOT (o0.\"queue\" IS NULL)) AND (o0.\"scheduled_at\" <= $2) RETURNING o0.\"queue\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: ["queue"],
           command: :update,
           connection_id: 120,
           messages: [],
           num_rows: 0,
           rows: []
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 16700,
      query_time: 1_177_500,
      total_time: 1_194_200
    },
    metadata: %{
      options: [],
      params: ["secret.oban_insert"],
      query:
        "SELECT pg_notify($1, json_build_object('queue', o0.\"queue\")::text) FROM \"secret\".\"oban_jobs\" AS o0 WHERE (o0.\"state\" = 'available') AND (NOT (o0.\"queue\" IS NULL))",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: ["pg_notify"],
           command: :select,
           connection_id: 120,
           messages: [],
           num_rows: 18,
           rows: [
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 2_845_400, total_time: 2_845_400},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 120,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 17200,
      idle_time: 659_785_500,
      query_time: 3_854_900,
      queue_time: 1_079_400,
      total_time: 4_951_500
    },
    metadata: %{
      options: [],
      params: [
        "completed",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {748_687, 6},
          minute: 8,
          month: 2,
          second: 19,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        196_298
      ],
      query: "UPDATE \"public\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"completed_at\" = $2 WHERE (o0.\"id\" = $3)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :update,
           connection_id: 122,
           messages: [],
           num_rows: 1,
           rows: nil
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 662_521_200,
      query_time: 501_900,
      queue_time: 66400,
      total_time: 568_300
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 124,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 20600,
      query_time: 3_384_200,
      total_time: 3_404_800
    },
    metadata: %{
      options: [],
      params: [
        "executing",
        %{
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
        ["a000037d44aa", "default", "4gtct002"],
        1,
        "default",
        1
      ],
      query:
        "UPDATE \"public\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"attempted_at\" = $2, \"attempted_by\" = $3, \"attempt\" = o0.\"attempt\" + $4 WHERE (o0.\"id\" IN (SELECT so0.\"id\" FROM \"public\".\"oban_jobs\" AS so0 WHERE (so0.\"state\" = 'available') AND (so0.\"queue\" = $5) ORDER BY so0.\"priority\", so0.\"scheduled_at\", so0.\"id\" LIMIT $6 FOR UPDATE SKIP LOCKED)) RETURNING o0.\"id\", o0.\"state\", o0.\"queue\", o0.\"worker\", o0.\"args\", o0.\"errors\", o0.\"tags\", o0.\"attempt\", o0.\"attempted_by\", o0.\"max_attempts\", o0.\"meta\", o0.\"priority\", o0.\"attempted_at\", o0.\"completed_at\", o0.\"discarded_at\", o0.\"cancelled_at\", o0.\"inserted_at\", o0.\"scheduled_at\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: [
             "id",
             "state",
             "queue",
             "worker",
             "args",
             "errors",
             "tags",
             "attempt",
             "attempted_by",
             "max_attempts",
             "meta",
             "priority",
             "attempted_at",
             "completed_at",
             "discarded_at",
             "cancelled_at",
             "inserted_at",
             "scheduled_at"
           ],
           command: :update,
           connection_id: 124,
           messages: [],
           num_rows: 1,
           rows: [
             [
               195_905,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 547},
               [
                 %{
                   "at" => "2021-02-16T05:07:24.493719Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "4gtct002"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {754_624, 6},
                 minute: 8,
                 month: 2,
                 second: 19,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {758_824, 6},
                 minute: 7,
                 month: 2,
                 second: 22,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {493_692, 6},
                 minute: 7,
                 month: 2,
                 second: 41,
                 year: 2021
               }
             ]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 1_619_200, total_time: 1_619_200},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 124,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 15700,
      idle_time: 1_006_837_800,
      query_time: 2_567_000,
      queue_time: 111_500,
      total_time: 2_694_200
    },
    metadata: %{
      options: [],
      params: [
        "completed",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {103_810, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        196_302
      ],
      query: "UPDATE \"public\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"completed_at\" = $2 WHERE (o0.\"id\" = $3)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :update,
           connection_id: 127,
           messages: [],
           num_rows: 1,
           rows: nil
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 1_007_808_100,
      query_time: 546_100,
      queue_time: 49500,
      total_time: 595_600
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 125,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 16700,
      query_time: 1_406_200,
      total_time: 1_422_900
    },
    metadata: %{
      options: [],
      params: [
        "executing",
        %{
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
        ["a000037d44aa", "default", "4gtct002"],
        1,
        "default",
        1
      ],
      query:
        "UPDATE \"public\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"attempted_at\" = $2, \"attempted_by\" = $3, \"attempt\" = o0.\"attempt\" + $4 WHERE (o0.\"id\" IN (SELECT so0.\"id\" FROM \"public\".\"oban_jobs\" AS so0 WHERE (so0.\"state\" = 'available') AND (so0.\"queue\" = $5) ORDER BY so0.\"priority\", so0.\"scheduled_at\", so0.\"id\" LIMIT $6 FOR UPDATE SKIP LOCKED)) RETURNING o0.\"id\", o0.\"state\", o0.\"queue\", o0.\"worker\", o0.\"args\", o0.\"errors\", o0.\"tags\", o0.\"attempt\", o0.\"attempted_by\", o0.\"max_attempts\", o0.\"meta\", o0.\"priority\", o0.\"attempted_at\", o0.\"completed_at\", o0.\"discarded_at\", o0.\"cancelled_at\", o0.\"inserted_at\", o0.\"scheduled_at\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: [
             "id",
             "state",
             "queue",
             "worker",
             "args",
             "errors",
             "tags",
             "attempt",
             "attempted_by",
             "max_attempts",
             "meta",
             "priority",
             "attempted_at",
             "completed_at",
             "discarded_at",
             "cancelled_at",
             "inserted_at",
             "scheduled_at"
           ],
           command: :update,
           connection_id: 125,
           messages: [],
           num_rows: 1,
           rows: [
             [
               195_948,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 756},
               [
                 %{
                   "at" => "2021-02-16T05:07:26.394157Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "4gtct002"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {107_013, 6},
                 minute: 8,
                 month: 2,
                 second: 20,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {505_336, 6},
                 minute: 7,
                 month: 2,
                 second: 24,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {394_131, 6},
                 minute: 7,
                 month: 2,
                 second: 42,
                 year: 2021
               }
             ]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 1_517_400, total_time: 1_517_400},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 125,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 1_031_225_800,
      query_time: 926_700,
      queue_time: 355_500,
      total_time: 1_282_200
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 118,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{decode_time: 10400, query_time: 387_100, total_time: 397_500},
    metadata: %{
      options: [],
      params: [1_149_979_440_289_383_533],
      query: "SELECT pg_try_advisory_xact_lock($1)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: ["pg_try_advisory_xact_lock"],
           command: :select,
           connection_id: 118,
           messages: [],
           num_rows: 1,
           rows: [[true]]
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 18200,
      query_time: 6_130_000,
      total_time: 6_148_200
    },
    metadata: %{
      options: [],
      params: [
        "available",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {144_566, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        }
      ],
      query:
        "UPDATE \"public\".\"oban_jobs\" AS o0 SET \"state\" = $1 WHERE (o0.\"state\" IN ('scheduled','retryable')) AND (NOT (o0.\"queue\" IS NULL)) AND (o0.\"scheduled_at\" <= $2) RETURNING o0.\"queue\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: ["queue"],
           command: :update,
           connection_id: 118,
           messages: [],
           num_rows: 0,
           rows: []
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 17300,
      query_time: 1_585_100,
      total_time: 1_602_400
    },
    metadata: %{
      options: [],
      params: ["public.oban_insert"],
      query:
        "SELECT pg_notify($1, json_build_object('queue', o0.\"queue\")::text) FROM \"public\".\"oban_jobs\" AS o0 WHERE (o0.\"state\" = 'available') AND (NOT (o0.\"queue\" IS NULL))",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: ["pg_notify"],
           command: :select,
           connection_id: 118,
           messages: [],
           num_rows: 32,
           rows: [
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 1_655_500, total_time: 1_655_500},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 118,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 1_102_503_000,
      query_time: 1_220_700,
      queue_time: 200_700,
      total_time: 1_421_400
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 119,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{decode_time: 18700, query_time: 990_900, total_time: 1_009_600},
    metadata: %{
      options: [],
      params: [1_149_979_440_356_993_929],
      query: "SELECT pg_try_advisory_xact_lock($1)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: ["pg_try_advisory_xact_lock"],
           command: :select,
           connection_id: 119,
           messages: [],
           num_rows: 1,
           rows: [[true]]
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 18700,
      query_time: 2_337_800,
      total_time: 2_356_500
    },
    metadata: %{
      options: [],
      params: [
        "available",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {220_791, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        }
      ],
      query:
        "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1 WHERE (o0.\"state\" IN ('scheduled','retryable')) AND (NOT (o0.\"queue\" IS NULL)) AND (o0.\"scheduled_at\" <= $2) RETURNING o0.\"queue\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: ["queue"],
           command: :update,
           connection_id: 119,
           messages: [],
           num_rows: 0,
           rows: []
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 18700,
      query_time: 1_886_700,
      total_time: 1_905_400
    },
    metadata: %{
      options: [],
      params: ["secret.oban_insert"],
      query:
        "SELECT pg_notify($1, json_build_object('queue', o0.\"queue\")::text) FROM \"secret\".\"oban_jobs\" AS o0 WHERE (o0.\"state\" = 'available') AND (NOT (o0.\"queue\" IS NULL))",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: ["pg_notify"],
           command: :select,
           connection_id: 119,
           messages: [],
           num_rows: 17,
           rows: [
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void],
             [:void]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 1_280_200, total_time: 1_280_200},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 119,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 22700,
      idle_time: 1_219_522_700,
      query_time: 18_581_100,
      queue_time: 424_300,
      total_time: 19_028_100
    },
    metadata: %{
      options: [],
      params: [
        "completed",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {335_586, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        195_905
      ],
      query: "UPDATE \"public\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"completed_at\" = $2 WHERE (o0.\"id\" = $3)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :update,
           connection_id: 126,
           messages: [],
           num_rows: 1,
           rows: nil
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 14700,
      idle_time: 1_205_159_400,
      query_time: 4_862_600,
      queue_time: 6_085_800,
      total_time: 10_963_100
    },
    metadata: %{
      options: [],
      params: [
        "completed",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {341_795, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        197_063
      ],
      query: "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"completed_at\" = $2 WHERE (o0.\"id\" = $3)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :update,
           connection_id: 121,
           messages: [],
           num_rows: 1,
           rows: nil
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 19400,
      idle_time: 1_213_869_000,
      query_time: 4_141_500,
      queue_time: 7_989_200,
      total_time: 12_150_100
    },
    metadata: %{
      options: [],
      params: [
        "completed",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {342_656, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        197_070
      ],
      query: "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"completed_at\" = $2 WHERE (o0.\"id\" = $3)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :update,
           connection_id: 123,
           messages: [],
           num_rows: 1,
           rows: nil
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 602_751_000,
      query_time: 529_000,
      queue_time: 61400,
      total_time: 590_400
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 122,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 1_142_179_400,
      query_time: 845_000,
      queue_time: 64100,
      total_time: 909_100
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 120,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 17100,
      query_time: 3_842_200,
      total_time: 3_859_300
    },
    metadata: %{
      options: [],
      params: [
        "executing",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {356_811, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        ["a000037d44aa", "default", "m8icetgo"],
        1,
        "default",
        1
      ],
      query:
        "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"attempted_at\" = $2, \"attempted_by\" = $3, \"attempt\" = o0.\"attempt\" + $4 WHERE (o0.\"id\" IN (SELECT so0.\"id\" FROM \"secret\".\"oban_jobs\" AS so0 WHERE (so0.\"state\" = 'available') AND (so0.\"queue\" = $5) ORDER BY so0.\"priority\", so0.\"scheduled_at\", so0.\"id\" LIMIT $6 FOR UPDATE SKIP LOCKED)) RETURNING o0.\"id\", o0.\"state\", o0.\"queue\", o0.\"worker\", o0.\"args\", o0.\"errors\", o0.\"tags\", o0.\"attempt\", o0.\"attempted_by\", o0.\"max_attempts\", o0.\"meta\", o0.\"priority\", o0.\"attempted_at\", o0.\"completed_at\", o0.\"discarded_at\", o0.\"cancelled_at\", o0.\"inserted_at\", o0.\"scheduled_at\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: [
             "id",
             "state",
             "queue",
             "worker",
             "args",
             "errors",
             "tags",
             "attempt",
             "attempted_by",
             "max_attempts",
             "meta",
             "priority",
             "attempted_at",
             "completed_at",
             "discarded_at",
             "cancelled_at",
             "inserted_at",
             "scheduled_at"
           ],
           command: :update,
           connection_id: 122,
           messages: [],
           num_rows: 1,
           rows: [
             [
               196_385,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 1050},
               [
                 %{
                   "at" => "2021-02-16T05:07:09.552822Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 },
                 %{
                   "at" => "2021-02-16T05:07:27.387394Z",
                   "attempt" => 2,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               3,
               ["a000037d44aa", "default", "m8icetgo"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {356_811, 6},
                 minute: 8,
                 month: 2,
                 second: 20,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {401_784, 6},
                 minute: 6,
                 month: 2,
                 second: 33,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {387_367, 6},
                 minute: 7,
                 month: 2,
                 second: 45,
                 year: 2021
               }
             ]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 16300,
      query_time: 6_974_100,
      total_time: 6_990_400
    },
    metadata: %{
      options: [],
      params: [
        "executing",
        %{
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
        ["a000037d44aa", "default", "4gtct002"],
        1,
        "default",
        1
      ],
      query:
        "UPDATE \"public\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"attempted_at\" = $2, \"attempted_by\" = $3, \"attempt\" = o0.\"attempt\" + $4 WHERE (o0.\"id\" IN (SELECT so0.\"id\" FROM \"public\".\"oban_jobs\" AS so0 WHERE (so0.\"state\" = 'available') AND (so0.\"queue\" = $5) ORDER BY so0.\"priority\", so0.\"scheduled_at\", so0.\"id\" LIMIT $6 FOR UPDATE SKIP LOCKED)) RETURNING o0.\"id\", o0.\"state\", o0.\"queue\", o0.\"worker\", o0.\"args\", o0.\"errors\", o0.\"tags\", o0.\"attempt\", o0.\"attempted_by\", o0.\"max_attempts\", o0.\"meta\", o0.\"priority\", o0.\"attempted_at\", o0.\"completed_at\", o0.\"discarded_at\", o0.\"cancelled_at\", o0.\"inserted_at\", o0.\"scheduled_at\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: [
             "id",
             "state",
             "queue",
             "worker",
             "args",
             "errors",
             "tags",
             "attempt",
             "attempted_by",
             "max_attempts",
             "meta",
             "priority",
             "attempted_at",
             "completed_at",
             "discarded_at",
             "cancelled_at",
             "inserted_at",
             "scheduled_at"
           ],
           command: :update,
           connection_id: 120,
           messages: [],
           num_rows: 1,
           rows: [
             [
               195_969,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 1758},
               [
                 %{
                   "at" => "2021-02-16T05:07:27.048595Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "4gtct002"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {356_730, 6},
                 minute: 8,
                 month: 2,
                 second: 20,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {777_509, 6},
                 minute: 7,
                 month: 2,
                 second: 24,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {48569, 6},
                 minute: 7,
                 month: 2,
                 second: 44,
                 year: 2021
               }
             ]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 4_047_800, total_time: 4_047_800},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 122,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 1_632_700, total_time: 1_632_700},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 120,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 20400,
      idle_time: 607_350_800,
      query_time: 3_575_500,
      queue_time: 101_700,
      total_time: 3_697_600
    },
    metadata: %{
      options: [],
      params: [
        "retryable",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {367_119, 6},
          minute: 8,
          month: 2,
          second: 38,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        %{
          at: %{
            __struct__: DateTime,
            calendar: Calendar.ISO,
            day: 16,
            hour: 5,
            microsecond: {367_151, 6},
            minute: 8,
            month: 2,
            second: 20,
            std_offset: 0,
            time_zone: "Etc/UTC",
            utc_offset: 0,
            year: 2021,
            zone_abbr: "UTC"
          },
          attempt: 2,
          error:
            "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
        },
        195_969
      ],
      query:
        "UPDATE \"public\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"scheduled_at\" = $2, \"errors\" = array_append(o0.\"errors\", $3) WHERE (o0.\"id\" = $4)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :update,
           connection_id: 124,
           messages: [],
           num_rows: 1,
           rows: nil
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 261_710_900,
      query_time: 358_900,
      queue_time: 50700,
      total_time: 409_600
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 125,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 265_615_300,
      query_time: 1_240_000,
      queue_time: 76500,
      total_time: 1_316_500
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 127,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 16500,
      query_time: 1_577_300,
      total_time: 1_593_800
    },
    metadata: %{
      options: [],
      params: [
        "executing",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {372_516, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        ["a000037d44aa", "default", "4gtct002"],
        1,
        "default",
        1
      ],
      query:
        "UPDATE \"public\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"attempted_at\" = $2, \"attempted_by\" = $3, \"attempt\" = o0.\"attempt\" + $4 WHERE (o0.\"id\" IN (SELECT so0.\"id\" FROM \"public\".\"oban_jobs\" AS so0 WHERE (so0.\"state\" = 'available') AND (so0.\"queue\" = $5) ORDER BY so0.\"priority\", so0.\"scheduled_at\", so0.\"id\" LIMIT $6 FOR UPDATE SKIP LOCKED)) RETURNING o0.\"id\", o0.\"state\", o0.\"queue\", o0.\"worker\", o0.\"args\", o0.\"errors\", o0.\"tags\", o0.\"attempt\", o0.\"attempted_by\", o0.\"max_attempts\", o0.\"meta\", o0.\"priority\", o0.\"attempted_at\", o0.\"completed_at\", o0.\"discarded_at\", o0.\"cancelled_at\", o0.\"inserted_at\", o0.\"scheduled_at\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: [
             "id",
             "state",
             "queue",
             "worker",
             "args",
             "errors",
             "tags",
             "attempt",
             "attempted_by",
             "max_attempts",
             "meta",
             "priority",
             "attempted_at",
             "completed_at",
             "discarded_at",
             "cancelled_at",
             "inserted_at",
             "scheduled_at"
           ],
           command: :update,
           connection_id: 125,
           messages: [],
           num_rows: 1,
           rows: [
             [
               195_959,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 1307},
               [
                 %{
                   "at" => "2021-02-16T05:07:26.989700Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "4gtct002"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {372_516, 6},
                 minute: 8,
                 month: 2,
                 second: 20,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {567_517, 6},
                 minute: 7,
                 month: 2,
                 second: 24,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {989_673, 6},
                 minute: 7,
                 month: 2,
                 second: 44,
                 year: 2021
               }
             ]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 14800,
      query_time: 1_883_900,
      total_time: 1_898_700
    },
    metadata: %{
      options: [],
      params: [
        "executing",
        %{
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
        ["a000037d44aa", "default", "m8icetgo"],
        1,
        "default",
        1
      ],
      query:
        "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"attempted_at\" = $2, \"attempted_by\" = $3, \"attempt\" = o0.\"attempt\" + $4 WHERE (o0.\"id\" IN (SELECT so0.\"id\" FROM \"secret\".\"oban_jobs\" AS so0 WHERE (so0.\"state\" = 'available') AND (so0.\"queue\" = $5) ORDER BY so0.\"priority\", so0.\"scheduled_at\", so0.\"id\" LIMIT $6 FOR UPDATE SKIP LOCKED)) RETURNING o0.\"id\", o0.\"state\", o0.\"queue\", o0.\"worker\", o0.\"args\", o0.\"errors\", o0.\"tags\", o0.\"attempt\", o0.\"attempted_by\", o0.\"max_attempts\", o0.\"meta\", o0.\"priority\", o0.\"attempted_at\", o0.\"completed_at\", o0.\"discarded_at\", o0.\"cancelled_at\", o0.\"inserted_at\", o0.\"scheduled_at\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: [
             "id",
             "state",
             "queue",
             "worker",
             "args",
             "errors",
             "tags",
             "attempt",
             "attempted_by",
             "max_attempts",
             "meta",
             "priority",
             "attempted_at",
             "completed_at",
             "discarded_at",
             "cancelled_at",
             "inserted_at",
             "scheduled_at"
           ],
           command: :update,
           connection_id: 127,
           messages: [],
           num_rows: 1,
           rows: [
             [
               196_841,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 290},
               [
                 %{
                   "at" => "2021-02-16T05:07:29.185768Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "m8icetgo"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {372_153, 6},
                 minute: 8,
                 month: 2,
                 second: 20,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {364_118, 6},
                 minute: 7,
                 month: 2,
                 second: 26,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {185_715, 6},
                 minute: 7,
                 month: 2,
                 second: 46,
                 year: 2021
               }
             ]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 1_450_600, total_time: 1_450_600},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 125,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 1_546_900, total_time: 1_546_900},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 127,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 14500,
      idle_time: 548_687_000,
      query_time: 2_499_800,
      queue_time: 84300,
      total_time: 2_598_600
    },
    metadata: %{
      options: [],
      params: [
        "completed",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {702_820, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        196_841
      ],
      query: "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"completed_at\" = $2 WHERE (o0.\"id\" = $3)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :update,
           connection_id: 118,
           messages: [],
           num_rows: 1,
           rows: nil
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 479_155_400,
      query_time: 519_700,
      queue_time: 71300,
      total_time: 591_000
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 119,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 16800,
      query_time: 2_386_300,
      total_time: 2_403_100
    },
    metadata: %{
      options: [],
      params: [
        "executing",
        %{
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
        ["a000037d44aa", "default", "m8icetgo"],
        1,
        "default",
        1
      ],
      query:
        "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"attempted_at\" = $2, \"attempted_by\" = $3, \"attempt\" = o0.\"attempt\" + $4 WHERE (o0.\"id\" IN (SELECT so0.\"id\" FROM \"secret\".\"oban_jobs\" AS so0 WHERE (so0.\"state\" = 'available') AND (so0.\"queue\" = $5) ORDER BY so0.\"priority\", so0.\"scheduled_at\", so0.\"id\" LIMIT $6 FOR UPDATE SKIP LOCKED)) RETURNING o0.\"id\", o0.\"state\", o0.\"queue\", o0.\"worker\", o0.\"args\", o0.\"errors\", o0.\"tags\", o0.\"attempt\", o0.\"attempted_by\", o0.\"max_attempts\", o0.\"meta\", o0.\"priority\", o0.\"attempted_at\", o0.\"completed_at\", o0.\"discarded_at\", o0.\"cancelled_at\", o0.\"inserted_at\", o0.\"scheduled_at\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: [
             "id",
             "state",
             "queue",
             "worker",
             "args",
             "errors",
             "tags",
             "attempt",
             "attempted_by",
             "max_attempts",
             "meta",
             "priority",
             "attempted_at",
             "completed_at",
             "discarded_at",
             "cancelled_at",
             "inserted_at",
             "scheduled_at"
           ],
           command: :update,
           connection_id: 119,
           messages: [],
           num_rows: 1,
           rows: [
             [
               196_386,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 635},
               [
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
               [],
               3,
               ["a000037d44aa", "default", "m8icetgo"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {705_797, 6},
                 minute: 8,
                 month: 2,
                 second: 20,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {411_859, 6},
                 minute: 6,
                 month: 2,
                 second: 33,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {788_834, 6},
                 minute: 7,
                 month: 2,
                 second: 46,
                 year: 2021
               }
             ]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 1_353_300, total_time: 1_353_300},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 119,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 25700,
      idle_time: 465_594_500,
      query_time: 3_966_200,
      queue_time: 366_000,
      total_time: 4_357_900
    },
    metadata: %{
      options: [],
      params: [
        "completed",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {820_132, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        196_300
      ],
      query: "UPDATE \"public\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"completed_at\" = $2 WHERE (o0.\"id\" = $3)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :update,
           connection_id: 126,
           messages: [],
           num_rows: 1,
           rows: nil
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 470_325_500,
      query_time: 412_400,
      queue_time: 63500,
      total_time: 475_900
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 123,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 16600,
      query_time: 2_729_900,
      total_time: 2_746_500
    },
    metadata: %{
      options: [],
      params: [
        "executing",
        %{
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
        ["a000037d44aa", "default", "4gtct002"],
        1,
        "default",
        1
      ],
      query:
        "UPDATE \"public\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"attempted_at\" = $2, \"attempted_by\" = $3, \"attempt\" = o0.\"attempt\" + $4 WHERE (o0.\"id\" IN (SELECT so0.\"id\" FROM \"public\".\"oban_jobs\" AS so0 WHERE (so0.\"state\" = 'available') AND (so0.\"queue\" = $5) ORDER BY so0.\"priority\", so0.\"scheduled_at\", so0.\"id\" LIMIT $6 FOR UPDATE SKIP LOCKED)) RETURNING o0.\"id\", o0.\"state\", o0.\"queue\", o0.\"worker\", o0.\"args\", o0.\"errors\", o0.\"tags\", o0.\"attempt\", o0.\"attempted_by\", o0.\"max_attempts\", o0.\"meta\", o0.\"priority\", o0.\"attempted_at\", o0.\"completed_at\", o0.\"discarded_at\", o0.\"cancelled_at\", o0.\"inserted_at\", o0.\"scheduled_at\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: [
             "id",
             "state",
             "queue",
             "worker",
             "args",
             "errors",
             "tags",
             "attempt",
             "attempted_by",
             "max_attempts",
             "meta",
             "priority",
             "attempted_at",
             "completed_at",
             "discarded_at",
             "cancelled_at",
             "inserted_at",
             "scheduled_at"
           ],
           command: :update,
           connection_id: 123,
           messages: [],
           num_rows: 1,
           rows: [
             [
               196_077,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 1386},
               [
                 %{
                   "at" => "2021-02-16T05:07:30.594231Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "4gtct002"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {825_238, 6},
                 minute: 8,
                 month: 2,
                 second: 20,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {887_344, 6},
                 minute: 7,
                 month: 2,
                 second: 27,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {594_205, 6},
                 minute: 7,
                 month: 2,
                 second: 46,
                 year: 2021
               }
             ]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 1_543_400, total_time: 1_543_400},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 123,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 14500,
      idle_time: 475_119_300,
      query_time: 1_818_700,
      queue_time: 68400,
      total_time: 1_901_600
    },
    metadata: %{
      options: [],
      params: [
        "retryable",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {830_732, 6},
          minute: 8,
          month: 2,
          second: 38,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        %{
          at: %{
            __struct__: DateTime,
            calendar: Calendar.ISO,
            day: 16,
            hour: 5,
            microsecond: {830_761, 6},
            minute: 8,
            month: 2,
            second: 20,
            std_offset: 0,
            time_zone: "Etc/UTC",
            utc_offset: 0,
            year: 2021,
            zone_abbr: "UTC"
          },
          attempt: 2,
          error:
            "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
        },
        196_077
      ],
      query:
        "UPDATE \"public\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"scheduled_at\" = $2, \"errors\" = array_append(o0.\"errors\", $3) WHERE (o0.\"id\" = $4)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :update,
           connection_id: 121,
           messages: [],
           num_rows: 1,
           rows: nil
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 482_507_000,
      query_time: 3_341_300,
      queue_time: 72100,
      total_time: 3_413_400
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 122,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 16500,
      query_time: 2_449_900,
      total_time: 2_466_400
    },
    metadata: %{
      options: [],
      params: [
        "executing",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {848_080, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        ["a000037d44aa", "default", "4gtct002"],
        1,
        "default",
        1
      ],
      query:
        "UPDATE \"public\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"attempted_at\" = $2, \"attempted_by\" = $3, \"attempt\" = o0.\"attempt\" + $4 WHERE (o0.\"id\" IN (SELECT so0.\"id\" FROM \"public\".\"oban_jobs\" AS so0 WHERE (so0.\"state\" = 'available') AND (so0.\"queue\" = $5) ORDER BY so0.\"priority\", so0.\"scheduled_at\", so0.\"id\" LIMIT $6 FOR UPDATE SKIP LOCKED)) RETURNING o0.\"id\", o0.\"state\", o0.\"queue\", o0.\"worker\", o0.\"args\", o0.\"errors\", o0.\"tags\", o0.\"attempt\", o0.\"attempted_by\", o0.\"max_attempts\", o0.\"meta\", o0.\"priority\", o0.\"attempted_at\", o0.\"completed_at\", o0.\"discarded_at\", o0.\"cancelled_at\", o0.\"inserted_at\", o0.\"scheduled_at\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: [
             "id",
             "state",
             "queue",
             "worker",
             "args",
             "errors",
             "tags",
             "attempt",
             "attempted_by",
             "max_attempts",
             "meta",
             "priority",
             "attempted_at",
             "completed_at",
             "discarded_at",
             "cancelled_at",
             "inserted_at",
             "scheduled_at"
           ],
           command: :update,
           connection_id: 122,
           messages: [],
           num_rows: 1,
           rows: [
             [
               196_120,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 1515},
               [
                 %{
                   "at" => "2021-02-16T05:07:32.100965Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "4gtct002"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {848_080, 6},
                 minute: 8,
                 month: 2,
                 second: 20,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {531_289, 6},
                 minute: 7,
                 month: 2,
                 second: 30,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {100_939, 6},
                 minute: 7,
                 month: 2,
                 second: 47,
                 year: 2021
               }
             ]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 1_713_200, total_time: 1_713_200},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 122,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 14500,
      idle_time: 502_220_400,
      query_time: 2_834_800,
      queue_time: 273_200,
      total_time: 3_122_500
    },
    metadata: %{
      options: [],
      params: [
        "completed",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {868_739, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        195_872
      ],
      query: "UPDATE \"public\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"completed_at\" = $2 WHERE (o0.\"id\" = $3)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :update,
           connection_id: 120,
           messages: [],
           num_rows: 1,
           rows: nil
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 500_871_400,
      query_time: 6_383_800,
      queue_time: 59700,
      total_time: 6_443_500
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 124,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 16300,
      query_time: 4_591_600,
      total_time: 4_607_900
    },
    metadata: %{
      options: [],
      params: [
        "executing",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {872_300, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        ["a000037d44aa", "default", "4gtct002"],
        1,
        "default",
        1
      ],
      query:
        "UPDATE \"public\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"attempted_at\" = $2, \"attempted_by\" = $3, \"attempt\" = o0.\"attempt\" + $4 WHERE (o0.\"id\" IN (SELECT so0.\"id\" FROM \"public\".\"oban_jobs\" AS so0 WHERE (so0.\"state\" = 'available') AND (so0.\"queue\" = $5) ORDER BY so0.\"priority\", so0.\"scheduled_at\", so0.\"id\" LIMIT $6 FOR UPDATE SKIP LOCKED)) RETURNING o0.\"id\", o0.\"state\", o0.\"queue\", o0.\"worker\", o0.\"args\", o0.\"errors\", o0.\"tags\", o0.\"attempt\", o0.\"attempted_by\", o0.\"max_attempts\", o0.\"meta\", o0.\"priority\", o0.\"attempted_at\", o0.\"completed_at\", o0.\"discarded_at\", o0.\"cancelled_at\", o0.\"inserted_at\", o0.\"scheduled_at\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: [
             "id",
             "state",
             "queue",
             "worker",
             "args",
             "errors",
             "tags",
             "attempt",
             "attempted_by",
             "max_attempts",
             "meta",
             "priority",
             "attempted_at",
             "completed_at",
             "discarded_at",
             "cancelled_at",
             "inserted_at",
             "scheduled_at"
           ],
           command: :update,
           connection_id: 124,
           messages: [],
           num_rows: 1,
           rows: [
             [
               196_069,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 1753},
               [
                 %{
                   "at" => "2021-02-16T05:07:30.164224Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "4gtct002"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {872_300, 6},
                 minute: 8,
                 month: 2,
                 second: 20,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {825_827, 6},
                 minute: 7,
                 month: 2,
                 second: 27,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {164_146, 6},
                 minute: 7,
                 month: 2,
                 second: 47,
                 year: 2021
               }
             ]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 10_818_500, total_time: 10_818_500},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 124,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 13800,
      idle_time: 516_204_000,
      query_time: 3_510_900,
      queue_time: 2_320_500,
      total_time: 5_845_200
    },
    metadata: %{
      options: [],
      params: [
        "completed",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {892_470, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        196_753
      ],
      query: "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"completed_at\" = $2 WHERE (o0.\"id\" = $3)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :update,
           connection_id: 125,
           messages: [],
           num_rows: 1,
           rows: nil
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 521_321_600,
      query_time: 965_600,
      queue_time: 57300,
      total_time: 1_022_900
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 127,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 16700,
      query_time: 1_404_000,
      total_time: 1_420_700
    },
    metadata: %{
      options: [],
      params: [
        "executing",
        %{
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
        ["a000037d44aa", "default", "m8icetgo"],
        1,
        "default",
        1
      ],
      query:
        "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"attempted_at\" = $2, \"attempted_by\" = $3, \"attempt\" = o0.\"attempt\" + $4 WHERE (o0.\"id\" IN (SELECT so0.\"id\" FROM \"secret\".\"oban_jobs\" AS so0 WHERE (so0.\"state\" = 'available') AND (so0.\"queue\" = $5) ORDER BY so0.\"priority\", so0.\"scheduled_at\", so0.\"id\" LIMIT $6 FOR UPDATE SKIP LOCKED)) RETURNING o0.\"id\", o0.\"state\", o0.\"queue\", o0.\"worker\", o0.\"args\", o0.\"errors\", o0.\"tags\", o0.\"attempt\", o0.\"attempted_by\", o0.\"max_attempts\", o0.\"meta\", o0.\"priority\", o0.\"attempted_at\", o0.\"completed_at\", o0.\"discarded_at\", o0.\"cancelled_at\", o0.\"inserted_at\", o0.\"scheduled_at\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: [
             "id",
             "state",
             "queue",
             "worker",
             "args",
             "errors",
             "tags",
             "attempt",
             "attempted_by",
             "max_attempts",
             "meta",
             "priority",
             "attempted_at",
             "completed_at",
             "discarded_at",
             "cancelled_at",
             "inserted_at",
             "scheduled_at"
           ],
           command: :update,
           connection_id: 127,
           messages: [],
           num_rows: 1,
           rows: [
             [
               196_873,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 4811},
               [
                 %{
                   "at" => "2021-02-16T05:07:30.559321Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "m8icetgo"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {898_594, 6},
                 minute: 8,
                 month: 2,
                 second: 20,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {748_319, 6},
                 minute: 7,
                 month: 2,
                 second: 27,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {559_289, 6},
                 minute: 7,
                 month: 2,
                 second: 47,
                 year: 2021
               }
             ]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 1_901_300, total_time: 1_901_300},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 127,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 14400,
      idle_time: 196_066_300,
      query_time: 9_353_500,
      queue_time: 168_200,
      total_time: 9_536_100
    },
    metadata: %{
      options: [],
      params: [
        "completed",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {901_549, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        196_297
      ],
      query: "UPDATE \"public\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"completed_at\" = $2 WHERE (o0.\"id\" = $3)",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :update,
           connection_id: 118,
           messages: [],
           num_rows: 1,
           rows: nil
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 80_887_100,
      query_time: 3_122_500,
      queue_time: 252_200,
      total_time: 3_374_700
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 123,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 78_005_400,
      query_time: 3_202_900,
      queue_time: 66900,
      total_time: 3_269_800
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 121,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 16300,
      query_time: 5_068_800,
      total_time: 5_085_100
    },
    metadata: %{
      options: [],
      params: [
        "executing",
        %{
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
        ["a000037d44aa", "default", "4gtct002"],
        1,
        "default",
        1
      ],
      query:
        "UPDATE \"public\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"attempted_at\" = $2, \"attempted_by\" = $3, \"attempt\" = o0.\"attempt\" + $4 WHERE (o0.\"id\" IN (SELECT so0.\"id\" FROM \"public\".\"oban_jobs\" AS so0 WHERE (so0.\"state\" = 'available') AND (so0.\"queue\" = $5) ORDER BY so0.\"priority\", so0.\"scheduled_at\", so0.\"id\" LIMIT $6 FOR UPDATE SKIP LOCKED)) RETURNING o0.\"id\", o0.\"state\", o0.\"queue\", o0.\"worker\", o0.\"args\", o0.\"errors\", o0.\"tags\", o0.\"attempt\", o0.\"attempted_by\", o0.\"max_attempts\", o0.\"meta\", o0.\"priority\", o0.\"attempted_at\", o0.\"completed_at\", o0.\"discarded_at\", o0.\"cancelled_at\", o0.\"inserted_at\", o0.\"scheduled_at\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: [
             "id",
             "state",
             "queue",
             "worker",
             "args",
             "errors",
             "tags",
             "attempt",
             "attempted_by",
             "max_attempts",
             "meta",
             "priority",
             "attempted_at",
             "completed_at",
             "discarded_at",
             "cancelled_at",
             "inserted_at",
             "scheduled_at"
           ],
           command: :update,
           connection_id: 121,
           messages: [],
           num_rows: 1,
           rows: [
             [
               196_065,
               "executing",
               "default",
               "WebApp.Jobs.DefaultWorker",
               %{"sleep_time" => 108},
               [
                 %{
                   "at" => "2021-02-16T05:07:29.979482Z",
                   "attempt" => 1,
                   "error" =>
                     "** (ArithmeticError) bad argument in arithmetic expression\n    (web_app 0.1.0) lib/web_app/jobs/default_worker.ex:9: WebApp.Jobs.DefaultWorker.perform/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:168: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:156: Oban.Queue.Executor.perform_inline/1\n    (oban 2.4.3) lib/oban/queue/executor.ex:79: Oban.Queue.Executor.call/1\n    (elixir 1.10.4) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2\n    (elixir 1.10.4) lib/task/supervised.ex:35: Task.Supervised.reply/5\n    (stdlib 3.12.1) proc_lib.erl:249: :proc_lib.init_p_do_apply/3\n"
                 }
               ],
               [],
               2,
               ["a000037d44aa", "default", "4gtct002"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {911_484, 6},
                 minute: 8,
                 month: 2,
                 second: 20,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {777_210, 6},
                 minute: 7,
                 month: 2,
                 second: 27,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {979_456, 6},
                 minute: 7,
                 month: 2,
                 second: 47,
                 year: 2021
               }
             ]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      idle_time: 62_096_500,
      query_time: 5_235_300,
      queue_time: 84100,
      total_time: 5_319_400
    },
    metadata: %{
      options: [],
      params: [],
      query: "begin",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :begin,
           connection_id: 122,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 3_817_300, total_time: 3_817_300},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 121,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 14900,
      query_time: 10_579_600,
      total_time: 10_594_500
    },
    metadata: %{
      options: [],
      params: [
        "executing",
        %{
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
        ["a000037d44aa", "media", "064jflfo"],
        1,
        "media",
        20
      ],
      query:
        "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"attempted_at\" = $2, \"attempted_by\" = $3, \"attempt\" = o0.\"attempt\" + $4 WHERE (o0.\"id\" IN (SELECT so0.\"id\" FROM \"secret\".\"oban_jobs\" AS so0 WHERE (so0.\"state\" = 'available') AND (so0.\"queue\" = $5) ORDER BY so0.\"priority\", so0.\"scheduled_at\", so0.\"id\" LIMIT $6 FOR UPDATE SKIP LOCKED)) RETURNING o0.\"id\", o0.\"state\", o0.\"queue\", o0.\"worker\", o0.\"args\", o0.\"errors\", o0.\"tags\", o0.\"attempt\", o0.\"attempted_by\", o0.\"max_attempts\", o0.\"meta\", o0.\"priority\", o0.\"attempted_at\", o0.\"completed_at\", o0.\"discarded_at\", o0.\"cancelled_at\", o0.\"inserted_at\", o0.\"scheduled_at\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: [
             "id",
             "state",
             "queue",
             "worker",
             "args",
             "errors",
             "tags",
             "attempt",
             "attempted_by",
             "max_attempts",
             "meta",
             "priority",
             "attempted_at",
             "completed_at",
             "discarded_at",
             "cancelled_at",
             "inserted_at",
             "scheduled_at"
           ],
           command: :update,
           connection_id: 123,
           messages: [],
           num_rows: 1,
           rows: [
             [
               197_105,
               "executing",
               "media",
               "WebApp.Jobs.MediaWorker",
               %{"sleep_time" => 10},
               [],
               [],
               1,
               ["a000037d44aa", "media", "064jflfo"],
               20,
               %{},
               0,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {910_931, 6},
                 minute: 8,
                 month: 2,
                 second: 20,
                 year: 2021
               },
               nil,
               nil,
               nil,
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {851_345, 6},
                 minute: 8,
                 month: 2,
                 second: 20,
                 year: 2021
               },
               %{
                 __struct__: NaiveDateTime,
                 calendar: Calendar.ISO,
                 day: 16,
                 hour: 5,
                 microsecond: {851_345, 6},
                 minute: 8,
                 month: 2,
                 second: 20,
                 year: 2021
               }
             ]
           ]
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{
      decode_time: 13500,
      query_time: 1_852_000,
      total_time: 1_865_500
    },
    metadata: %{
      options: [],
      params: [
        "executing",
        %{
          __struct__: DateTime,
          calendar: Calendar.ISO,
          day: 16,
          hour: 5,
          microsecond: {918_396, 6},
          minute: 8,
          month: 2,
          second: 20,
          std_offset: 0,
          time_zone: "Etc/UTC",
          utc_offset: 0,
          year: 2021,
          zone_abbr: "UTC"
        },
        ["a000037d44aa", "events", "ppgg793m"],
        1,
        "events",
        50
      ],
      query:
        "UPDATE \"secret\".\"oban_jobs\" AS o0 SET \"state\" = $1, \"attempted_at\" = $2, \"attempted_by\" = $3, \"attempt\" = o0.\"attempt\" + $4 WHERE (o0.\"id\" IN (SELECT so0.\"id\" FROM \"secret\".\"oban_jobs\" AS so0 WHERE (so0.\"state\" = 'available') AND (so0.\"queue\" = $5) ORDER BY so0.\"priority\", so0.\"scheduled_at\", so0.\"id\" LIMIT $6 FOR UPDATE SKIP LOCKED)) RETURNING o0.\"id\", o0.\"state\", o0.\"queue\", o0.\"worker\", o0.\"args\", o0.\"errors\", o0.\"tags\", o0.\"attempt\", o0.\"attempted_by\", o0.\"max_attempts\", o0.\"meta\", o0.\"priority\", o0.\"attempted_at\", o0.\"completed_at\", o0.\"discarded_at\", o0.\"cancelled_at\", o0.\"inserted_at\", o0.\"scheduled_at\"",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: [
             "id",
             "state",
             "queue",
             "worker",
             "args",
             "errors",
             "tags",
             "attempt",
             "attempted_by",
             "max_attempts",
             "meta",
             "priority",
             "attempted_at",
             "completed_at",
             "discarded_at",
             "cancelled_at",
             "inserted_at",
             "scheduled_at"
           ],
           command: :update,
           connection_id: 122,
           messages: [],
           num_rows: 0,
           rows: []
         }},
      source: "oban_jobs",
      type: :ecto_sql_query
    }
  },
  %{
    event: [:prom_ex, :plugin, :ecto, :query],
    measurements: %{query_time: 1_848_800, total_time: 1_848_800},
    metadata: %{
      options: [],
      params: [],
      query: "commit",
      repo: WebApp.Repo,
      result:
        {:ok,
         %{
           __struct__: Postgrex.Result,
           columns: nil,
           command: :commit,
           connection_id: 122,
           messages: [],
           num_rows: nil,
           rows: nil
         }},
      source: nil,
      type: :ecto_sql_query
    }
  }
]
