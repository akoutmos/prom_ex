[
  %{
    event: [:prom_ex, :broadway, :proxy, :processor, :init],
    measurements: %{},
    metadata: %{
      concurrency: 5,
      hibernate_after: 50000,
      max_demand: 10,
      name: "WebApp.TempProcessor",
      processor: :default
    }
  },
  %{
    event: [:prom_ex, :broadway, :proxy, :batcher, :init],
    measurements: %{},
    metadata: %{
      batch_size: 15,
      batch_timeout: 15000,
      batcher: :batch_temp,
      concurrency: 2,
      hibernate_after: 50000,
      name: "WebApp.TempProcessor"
    }
  },
  %{
    event: [:broadway, :topology, :init],
    measurements: %{system_time: -576_460_751_181_447_086},
    metadata: %{
      config: [
        context: :context_not_set,
        resubscribe_interval: 100,
        max_seconds: 5,
        max_restarts: 3,
        shutdown: 30000,
        name: WebApp.TempProcessor,
        hibernate_after: 50000,
        producer: [
          hibernate_after: 50000,
          concurrency: 1,
          module: {WebApp.CityProducer, []},
          transformer: {WebApp.TempProcessor, :transform, []},
          rate_limiting: [allowed_messages: 60, interval: 30000]
        ],
        processors: [
          default: [hibernate_after: 50000, max_demand: 10, concurrency: 5]
        ],
        batchers: [
          batch_temp: [
            hibernate_after: 50000,
            concurrency: 2,
            batch_size: 15,
            batch_timeout: 15000
          ]
        ]
      ]
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 109_832_327},
    metadata: %{
      context: :context_not_set,
      index: 0,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_0,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 164_834_637},
    metadata: %{
      context: :context_not_set,
      index: 1,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_1,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 206_836_682},
    metadata: %{
      context: :context_not_set,
      index: 4,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 441_068_398},
    metadata: %{
      context: :context_not_set,
      index: 1,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_1,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 427_949_990},
    metadata: %{
      context: :context_not_set,
      index: 4,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 917_885_256},
    metadata: %{
      context: :context_not_set,
      index: 3,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_3,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 267_940_590},
    metadata: %{
      context: :context_not_set,
      index: 3,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_3,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_185_886_429},
    metadata: %{
      context: :context_not_set,
      index: 2,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_2,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 601_005_611},
    metadata: %{
      context: :context_not_set,
      index: 4,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_495_074_773},
    metadata: %{
      context: :context_not_set,
      index: 0,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_0,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_086_912_046},
    metadata: %{
      context: :context_not_set,
      index: 1,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_1,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 643_969_794},
    metadata: %{
      context: :context_not_set,
      index: 3,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_3,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :exception],
    measurements: %{duration: 7624},
    metadata: %{
      context: :context_not_set,
      index: 3,
      kind: :error,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :default,
        data: {"Bissau", "Guinea-Bissau"},
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_3,
      processor_key: :default,
      reason: :badarith,
      stacktrace: [
        {WebApp.TempProcessor, :"-handle_message/3-fun-0-", 1, [file: ~c"lib/web_app/temp_processor.ex", line: 39]},
        {Broadway.Message, :update_data, 2, [file: ~c"lib/broadway/message.ex", line: 48]},
        {WebApp.TempProcessor, :handle_message, 3, [file: ~c"lib/web_app/temp_processor.ex", line: 32]},
        {Broadway.Topology.ProcessorStage, :"-handle_messages/4-fun-0-", 6,
         [file: ~c"lib/broadway/topology/processor_stage.ex", line: 156]},
        {:telemetry, :span, 3,
         [
           file:
             "/home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/telemetry/src/telemetry.erl",
           line: 293
         ]},
        {Broadway.Topology.ProcessorStage, :handle_messages, 4,
         [file: ~c"lib/broadway/topology/processor_stage.ex", line: 143]},
        {Broadway.Topology.ProcessorStage, :"-handle_events/3-fun-0-", 2,
         [file: ~c"lib/broadway/topology/processor_stage.ex", line: 63]},
        {:telemetry, :span, 3,
         [
           file:
             "/home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/telemetry/src/telemetry.erl",
           line: 293
         ]},
        {GenStage, :consumer_dispatch, 6, [file: ~c"lib/gen_stage.ex", line: 2471]},
        {GenStage, :take_pc_events, 3, [file: ~c"lib/gen_stage.ex", line: 2660]},
        {:gen_server, :try_dispatch, 4, [file: ~c"gen_server.erl", line: 695]},
        {:gen_server, :handle_msg, 6, [file: ~c"gen_server.erl", line: 771]},
        {:proc_lib, :init_p_do_apply, 3, [file: ~c"proc_lib.erl", line: 226]}
      ],
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_393_969_418},
    metadata: %{
      context: :context_not_set,
      index: 2,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_2,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 992_894_496},
    metadata: %{
      context: :context_not_set,
      index: 0,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_0,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_216_896_727},
    metadata: %{
      context: :context_not_set,
      index: 3,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_3,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 480_950_279},
    metadata: %{
      context: :context_not_set,
      index: 0,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_0,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_430_857_838},
    metadata: %{
      context: :context_not_set,
      index: 1,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_1,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_911_912_026},
    metadata: %{
      context: :context_not_set,
      index: 4,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :exception],
    measurements: %{duration: 6001},
    metadata: %{
      context: :context_not_set,
      index: 4,
      kind: :error,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :default,
        data: {"Canberra", "Australia"},
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default,
      reason: :badarith,
      stacktrace: [
        {WebApp.TempProcessor, :"-handle_message/3-fun-0-", 1, [file: ~c"lib/web_app/temp_processor.ex", line: 39]},
        {Broadway.Message, :update_data, 2, [file: ~c"lib/broadway/message.ex", line: 48]},
        {WebApp.TempProcessor, :handle_message, 3, [file: ~c"lib/web_app/temp_processor.ex", line: 32]},
        {Broadway.Topology.ProcessorStage, :"-handle_messages/4-fun-0-", 6,
         [file: ~c"lib/broadway/topology/processor_stage.ex", line: 156]},
        {:telemetry, :span, 3,
         [
           file:
             "/home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/telemetry/src/telemetry.erl",
           line: 293
         ]},
        {Broadway.Topology.ProcessorStage, :handle_messages, 4,
         [file: ~c"lib/broadway/topology/processor_stage.ex", line: 143]},
        {Broadway.Topology.ProcessorStage, :"-handle_events/3-fun-0-", 2,
         [file: ~c"lib/broadway/topology/processor_stage.ex", line: 63]},
        {:telemetry, :span, 3,
         [
           file:
             "/home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/telemetry/src/telemetry.erl",
           line: 293
         ]},
        {GenStage, :consumer_dispatch, 6, [file: ~c"lib/gen_stage.ex", line: 2471]},
        {GenStage, :take_pc_events, 3, [file: ~c"lib/gen_stage.ex", line: 2660]},
        {:gen_server, :try_dispatch, 4, [file: ~c"gen_server.erl", line: 695]},
        {:gen_server, :handle_msg, 6, [file: ~c"gen_server.erl", line: 771]},
        {:proc_lib, :init_p_do_apply, 3, [file: ~c"proc_lib.erl", line: 226]}
      ],
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 808_914_072},
    metadata: %{
      context: :context_not_set,
      index: 2,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_2,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 588_001_462},
    metadata: %{
      context: :context_not_set,
      index: 0,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_0,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_021_944_359},
    metadata: %{
      context: :context_not_set,
      index: 3,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_3,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_211_998_026},
    metadata: %{
      context: :context_not_set,
      index: 1,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_1,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 775_936_221},
    metadata: %{
      context: :context_not_set,
      index: 0,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_0,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 386_974_992},
    metadata: %{
      context: :context_not_set,
      index: 3,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_3,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_471_861_968},
    metadata: %{
      context: :context_not_set,
      index: 4,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 327_019_253},
    metadata: %{
      context: :context_not_set,
      index: 3,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_3,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_561_983_261},
    metadata: %{
      context: :context_not_set,
      index: 2,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_2,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 538_947_108},
    metadata: %{
      context: :context_not_set,
      index: 0,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_0,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 718_923_568},
    metadata: %{
      context: :context_not_set,
      index: 1,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_1,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 172_002_749},
    metadata: %{
      context: :context_not_set,
      index: 0,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_0,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 486_976_843},
    metadata: %{
      context: :context_not_set,
      index: 3,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_3,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 661_915_293},
    metadata: %{
      context: :context_not_set,
      index: 4,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 193_001_271},
    metadata: %{
      context: :context_not_set,
      index: 3,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_3,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 565_026_598},
    metadata: %{
      context: :context_not_set,
      index: 2,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_2,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 118_903_469},
    metadata: %{
      context: :context_not_set,
      index: 2,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_2,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :batch_processor, :stop],
    measurements: %{duration: 1_360_856_540},
    metadata: %{
      batch_info: %{
        __struct__: Broadway.BatchInfo,
        batch_key: :default,
        batcher: :batch_temp,
        partition: nil,
        size: 15,
        trigger: :size
      },
      context: :context_not_set,
      failed_messages: [],
      index: 0,
      name: WebApp.TempProcessor.Broadway.BatchProcessor_batch_temp_0,
      successful_messages: [
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        }
      ],
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 780_959_185},
    metadata: %{
      context: :context_not_set,
      index: 0,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_0,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_108_079_156},
    metadata: %{
      context: :context_not_set,
      index: 4,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_413_976_835},
    metadata: %{
      context: :context_not_set,
      index: 1,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_1,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :exception],
    measurements: %{duration: 6362},
    metadata: %{
      context: :context_not_set,
      index: 1,
      kind: :error,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :default,
        data: {"Avarua", "Cook Islands"},
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_1,
      processor_key: :default,
      reason: :badarith,
      stacktrace: [
        {WebApp.TempProcessor, :"-handle_message/3-fun-0-", 1, [file: ~c"lib/web_app/temp_processor.ex", line: 39]},
        {Broadway.Message, :update_data, 2, [file: ~c"lib/broadway/message.ex", line: 48]},
        {WebApp.TempProcessor, :handle_message, 3, [file: ~c"lib/web_app/temp_processor.ex", line: 32]},
        {Broadway.Topology.ProcessorStage, :"-handle_messages/4-fun-0-", 6,
         [file: ~c"lib/broadway/topology/processor_stage.ex", line: 156]},
        {:telemetry, :span, 3,
         [
           file:
             "/home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/telemetry/src/telemetry.erl",
           line: 293
         ]},
        {Broadway.Topology.ProcessorStage, :handle_messages, 4,
         [file: ~c"lib/broadway/topology/processor_stage.ex", line: 143]},
        {Broadway.Topology.ProcessorStage, :"-handle_events/3-fun-0-", 2,
         [file: ~c"lib/broadway/topology/processor_stage.ex", line: 63]},
        {:telemetry, :span, 3,
         [
           file:
             "/home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/telemetry/src/telemetry.erl",
           line: 293
         ]},
        {GenStage, :consumer_dispatch, 6, [file: ~c"lib/gen_stage.ex", line: 2471]},
        {GenStage, :take_pc_events, 3, [file: ~c"lib/gen_stage.ex", line: 2660]},
        {:gen_server, :try_dispatch, 4, [file: ~c"gen_server.erl", line: 695]},
        {:gen_server, :handle_msg, 6, [file: ~c"gen_server.erl", line: 771]},
        {:proc_lib, :init_p_do_apply, 3, [file: ~c"proc_lib.erl", line: 226]}
      ],
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_041_917_023},
    metadata: %{
      context: :context_not_set,
      index: 3,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_3,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 184_967_476},
    metadata: %{
      context: :context_not_set,
      index: 1,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_1,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_022_921_488},
    metadata: %{
      context: :context_not_set,
      index: 2,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_2,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 782_931_402},
    metadata: %{
      context: :context_not_set,
      index: 4,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 768_006_825},
    metadata: %{
      context: :context_not_set,
      index: 2,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_2,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_898_958_585},
    metadata: %{
      context: :context_not_set,
      index: 0,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_0,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :batch_processor, :stop],
    measurements: %{duration: 333_856_681},
    metadata: %{
      batch_info: %{
        __struct__: Broadway.BatchInfo,
        batch_key: :default,
        batcher: :batch_temp,
        partition: nil,
        size: 15,
        trigger: :size
      },
      context: :context_not_set,
      failed_messages: [],
      index: 1,
      name: WebApp.TempProcessor.Broadway.BatchProcessor_batch_temp_1,
      successful_messages: [
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        }
      ],
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_655_983_362},
    metadata: %{
      context: :context_not_set,
      index: 1,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_1,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_823_922_536},
    metadata: %{
      context: :context_not_set,
      index: 3,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_3,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_088_014_903},
    metadata: %{
      context: :context_not_set,
      index: 2,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_2,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_975_970_208},
    metadata: %{
      context: :context_not_set,
      index: 4,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 695_973_173},
    metadata: %{
      context: :context_not_set,
      index: 2,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_2,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_905_002_208},
    metadata: %{
      context: :context_not_set,
      index: 3,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_3,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 360_966_307},
    metadata: %{
      context: :context_not_set,
      index: 3,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_3,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_559_947_117},
    metadata: %{
      context: :context_not_set,
      index: 4,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :batch_processor, :stop],
    measurements: %{duration: 1_735_841_573},
    metadata: %{
      batch_info: %{
        __struct__: Broadway.BatchInfo,
        batch_key: :default,
        batcher: :batch_temp,
        partition: nil,
        size: 15,
        trigger: :size
      },
      context: :context_not_set,
      failed_messages: [],
      index: 0,
      name: WebApp.TempProcessor.Broadway.BatchProcessor_batch_temp_0,
      successful_messages: [
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        }
      ],
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 811_995_935},
    metadata: %{
      context: :context_not_set,
      index: 3,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_3,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_622_902_728},
    metadata: %{
      context: :context_not_set,
      index: 4,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 820_977_225},
    metadata: %{
      context: :context_not_set,
      index: 4,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :exception],
    measurements: %{duration: 7614},
    metadata: %{
      context: :context_not_set,
      index: 4,
      kind: :error,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :default,
        data: {"Douglas", "Isle of Man"},
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default,
      reason: :badarith,
      stacktrace: [
        {WebApp.TempProcessor, :"-handle_message/3-fun-0-", 1, [file: ~c"lib/web_app/temp_processor.ex", line: 39]},
        {Broadway.Message, :update_data, 2, [file: ~c"lib/broadway/message.ex", line: 48]},
        {WebApp.TempProcessor, :handle_message, 3, [file: ~c"lib/web_app/temp_processor.ex", line: 32]},
        {Broadway.Topology.ProcessorStage, :"-handle_messages/4-fun-0-", 6,
         [file: ~c"lib/broadway/topology/processor_stage.ex", line: 156]},
        {:telemetry, :span, 3,
         [
           file:
             "/home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/telemetry/src/telemetry.erl",
           line: 293
         ]},
        {Broadway.Topology.ProcessorStage, :handle_messages, 4,
         [file: ~c"lib/broadway/topology/processor_stage.ex", line: 143]},
        {Broadway.Topology.ProcessorStage, :"-handle_events/3-fun-0-", 2,
         [file: ~c"lib/broadway/topology/processor_stage.ex", line: 63]},
        {:telemetry, :span, 3,
         [
           file:
             "/home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/telemetry/src/telemetry.erl",
           line: 293
         ]},
        {GenStage, :consumer_dispatch, 6, [file: ~c"lib/gen_stage.ex", line: 2471]},
        {GenStage, :take_pc_events, 3, [file: ~c"lib/gen_stage.ex", line: 2660]},
        {:gen_server, :try_dispatch, 4, [file: ~c"gen_server.erl", line: 695]},
        {:gen_server, :handle_msg, 6, [file: ~c"gen_server.erl", line: 771]},
        {:proc_lib, :init_p_do_apply, 3, [file: ~c"proc_lib.erl", line: 226]}
      ],
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_765_949_526},
    metadata: %{
      context: :context_not_set,
      index: 4,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :batch_processor, :stop],
    measurements: %{duration: 690_940_306},
    metadata: %{
      batch_info: %{
        __struct__: Broadway.BatchInfo,
        batch_key: :default,
        batcher: :batch_temp,
        partition: nil,
        size: 11,
        trigger: :timeout
      },
      context: :context_not_set,
      failed_messages: [],
      index: 1,
      name: WebApp.TempProcessor.Broadway.BatchProcessor_batch_temp_1,
      successful_messages: [
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        }
      ],
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 614_930_511},
    metadata: %{
      context: :context_not_set,
      index: 0,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_0,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 827_992_048},
    metadata: %{
      context: :context_not_set,
      index: 1,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_1,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_058_940_563},
    metadata: %{
      context: :context_not_set,
      index: 4,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_098_920_069},
    metadata: %{
      context: :context_not_set,
      index: 2,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_2,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 842_960_213},
    metadata: %{
      context: :context_not_set,
      index: 1,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_1,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_767_920_948},
    metadata: %{
      context: :context_not_set,
      index: 3,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_3,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_189_972_602},
    metadata: %{
      context: :context_not_set,
      index: 2,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_2,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_274_907_913},
    metadata: %{
      context: :context_not_set,
      index: 4,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 746_905_944},
    metadata: %{
      context: :context_not_set,
      index: 1,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_1,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 247_949_463},
    metadata: %{
      context: :context_not_set,
      index: 2,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_2,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_971_922_848},
    metadata: %{
      context: :context_not_set,
      index: 0,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_0,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 289_023_026},
    metadata: %{
      context: :context_not_set,
      index: 1,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_1,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 893_958_369},
    metadata: %{
      context: :context_not_set,
      index: 2,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_2,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_966_966_717},
    metadata: %{
      context: :context_not_set,
      index: 3,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_3,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 173_923_653},
    metadata: %{
      context: :context_not_set,
      index: 3,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_3,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_869_021_931},
    metadata: %{
      context: :context_not_set,
      index: 4,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_989_972_578},
    metadata: %{
      context: :context_not_set,
      index: 0,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_0,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_884_931_406},
    metadata: %{
      context: :context_not_set,
      index: 1,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_1,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 778_973_700},
    metadata: %{
      context: :context_not_set,
      index: 3,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_3,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_321_938_419},
    metadata: %{
      context: :context_not_set,
      index: 2,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_2,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 168_902_128},
    metadata: %{
      context: :context_not_set,
      index: 2,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_2,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 485_962_321},
    metadata: %{
      context: :context_not_set,
      index: 0,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_0,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_017_980_878},
    metadata: %{
      context: :context_not_set,
      index: 2,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_2,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_773_856_778},
    metadata: %{
      context: :context_not_set,
      index: 4,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_837_993_030},
    metadata: %{
      context: :context_not_set,
      index: 1,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_1,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 579_000_491},
    metadata: %{
      context: :context_not_set,
      index: 2,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_2,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_853_022_280},
    metadata: %{
      context: :context_not_set,
      index: 3,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_3,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 163_982_683},
    metadata: %{
      context: :context_not_set,
      index: 2,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_2,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 1_675_002_951},
    metadata: %{
      context: :context_not_set,
      index: 0,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_0,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 866_023_531},
    metadata: %{
      context: :context_not_set,
      index: 4,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 571_921_363},
    metadata: %{
      context: :context_not_set,
      index: 3,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_3,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :batch_processor, :stop],
    measurements: %{duration: 730_817_368},
    metadata: %{
      batch_info: %{
        __struct__: Broadway.BatchInfo,
        batch_key: :default,
        batcher: :batch_temp,
        partition: nil,
        size: 15,
        trigger: :size
      },
      context: :context_not_set,
      failed_messages: [],
      index: 0,
      name: WebApp.TempProcessor.Broadway.BatchProcessor_batch_temp_0,
      successful_messages: [
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        },
        %{
          __struct__: Broadway.Message,
          acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :batch_temp,
          data: :ok,
          metadata: %{},
          status: :ok
        }
      ],
      topology_name: WebApp.TempProcessor
    }
  },
  %{
    event: [:broadway, :processor, :message, :stop],
    measurements: %{duration: 809_980_287},
    metadata: %{
      context: :context_not_set,
      index: 4,
      message: %{
        __struct__: Broadway.Message,
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :batch_temp,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default,
      topology_name: WebApp.TempProcessor
    }
  }
]
