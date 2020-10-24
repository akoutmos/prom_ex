%Doctor.Config{
  ignore_modules: [],
  ignore_paths: [~r/lib\/core.*/],
  min_module_doc_coverage: 90,
  min_module_spec_coverage: 90,
  min_overall_doc_coverage: 90,
  min_overall_spec_coverage: 90,
  moduledoc_required: true,
  raise: false,
  reporter: Doctor.Reporters.Full,
  struct_type_spec_required: true,
  umbrella: false
}
