#!/bin/bash

AB_BIN=/usr/bin/ab
GNUPLOT_BIN=/usr/bin/gnuplot
VERSION=0.2
DEFAULT_CONCURRENCY=1
DEFAULT_NUM_REQUESTS=1
TEST_DATE="$(date +%Y-%m-%d-%H-%M-%S)"
TEMPLATES_PATH="${PWD}/templates/"
CSV_TEMPLATE_FILE="${TEMPLATES_PATH}/percentages.tpl"
PLOT_TEMPLATE_FILE="${TEMPLATES_PATH}/values.tpl"
MERGE_VALUES_TEMPLATE_FILE="${TEMPLATES_PATH}/merged_values.tpl"
MERGE_PERCENTAGES_TEMPLATE_FILE="${TEMPLATES_PATH}/merged_percentages.tpl"

function extract_hostname() {
  local url=$1

  echo "${url}" | awk -F/ '{print $3}'
}

function render_template() {
  template_file=${1}
  result_file=${2}

  eval "echo \"$(cat ${template_file})\"" > "${result_file}"

  echo ${result_file}

}
