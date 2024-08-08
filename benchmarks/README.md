# apachebench-graph

Helper scripts for apachebench to automate the plotting of test results.

## Requirements

* apachebench
* bash
* gnuplot
* sed

## Usage

There are three helper script included:

* _ab_graph.sh_: Run an apache bench test and create plot result graphs using gnuplot.
* _ab_graph_merge.sh_: Merge various ab_graph.sh results graphs into a single one.
* _ab_graph_scale.sh_: Helper script for ab-graph that can run multiple configurable _ab_graph.sh_ runs in one go


### ab_graph.sh

This script has the following options:

```
Usage: $0 OPTIONS

OPTIONS:
-c    Concurrent connections  (default: 1)
-k    Enable keepalive        (default: no)
-E    Extra parameters
-n    Number of requests      (default: 1)
-u    Url to test             (mandatory)
-h    Print help.
-V    Debug mode.
```

This script will plot [apachebench](https://httpd.apache.org/docs/2.4/programs/ab.html) results using gnuplot, and store them
in _$PWD/results/$WESITEURL/$DATE/_. The script will create the plot files for gnuplot
using the templates in the [templates directory](templates/). It will also save apachebench
output in a file called _summary.txt_.


For example, this command:
```
./ab-graph.sh -u http://www.testsite.com/ -n 500 -c 100 -k
```
Will create the following results:

#### Test results

* [values.csv](example_results/values.csv)
* [percentages.csv](example_results/values.csv)

#### Test summary results
* summary.txt

```
This is ApacheBench, Version 2.3 <$Revision: 1843412 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking www.testsite.com (be patient)


Server Software:        nginx/1.10.3
Server Hostname:        www.testsite.com
Server Port:            80

Document Path:          //
Document Length:        4 bytes

Concurrency Level:      100
Time taken for tests:   26.012 seconds
Complete requests:      500
Failed requests:        0
Non-2xx responses:      500
Keep-Alive requests:    0
Total transferred:      200000 bytes
HTML transferred:       2000 bytes
Requests per second:    19.22 [#/sec] (mean)
Time per request:       5202.324 [ms] (mean)
Time per request:       52.023 [ms] (mean, across all concurrent requests)
Transfer rate:          7.51 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    1   1.3      0       7
Processing:   185 4926 1699.9   4718   10431
Waiting:      180 4925 1699.8   4718   10431
Total:        185 4926 1700.2   4718   10434

Percentage of the requests served within a certain time (ms)
  50%   4718
  66%   5203
  75%   5587
  80%   5781
  90%   7518
  95%   8573
  98%   9825
  99%  10228
 100%  10434 (longest request)
```

#### Plot templates

You can use templates to customize the graphs. Please refer to [gnuplot](http://www.gnuplot.info/documentation.html) documentation for that. These are the default templates:

* [values.p](example_results/values.p)
* [percentages.p](example_results/percentages.p)

#### Plotted results

##### Results
![Results graph](/example_results/values.tsv.png)

##### Percentiles
![Percentages graph](/example_results/percentages.csv.png)

### ab_graph_merge.sh

With this script you can merge various results from ab_graph.sh into one single graph, useful to compare results. For example, this command will merge two test results into one:

```
./ab-graph_merge.sh $PWD/results/www.testsite.com/2020-04-23-00-30-12 $PWD/results/www.testsite.com/2020-04-22-23-34-50
```

The resulting merged results graph looks like this:

#### Results
![Merged results graph](/example_results/merged_results/merged_values.png)
#### Percentiles
![Merged percentiles graph](/example_results/merged_results/merged_percentages.png)



### ab_graph_scale.sh

This helper script can do multiple runs of _ab_graph.sh_ in one go. It has many configurable parameters:

```
Usage: ./ab-graph_scale.sh OPTIONS

OPTIONS:
-c    Start concurrent connections at        (default: 5)
-e    Stop concurrent connections at         (default: 25)
-k    Enable keepalive connections           (default: no)
-s    Concurrent connections increment step  (default: 5)
-n    Number of requests                     (default: 500)
-u    Url to test                            (mandatory)
-w    Wait time between tests in seconds.    (default: 60s)
```

For example:

```
./ab-graph_scale.sh -c 10 -e 50 -k -s 10 -n 1000 -u https://www.test.com -w 30
```

Will do 1000 requests starting with 10 concurrent connections up to 50 in increments of 10, using keep alives and waiting 30 seconds between tests.
