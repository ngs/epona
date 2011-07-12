(push-loadpath "lib")

(load "test.arc")
(load "epona/conf.arc")

; conf* ----------------------------------------------------------------------

(test conf* (obj db-port 5984 repl-port 8081 srv-host "127.0.0.1" srv-port 8080 srv-timeout 30 db-host "127.0.0.1" pubdir "/pub" tmpdir "/tmp" logdir "/log") istab)

; load-conf ------------------------------------------------------------------

(= appdir* "/tmp")

(test (let file "/tmp/epona-conf-test"
        (w/outfile o file
            (w/stdout o
              (prn "((srv-port 5000) (debug t) (repl-port nil))"))
        load-conf.file
        rmfile.file
        conf*))
      (obj debug t db-port 5984 srv-host "127.0.0.1" srv-port 5000 srv-timeout 30 db-host "127.0.0.1" pubdir "/tmp/pub" tmpdir "/tmp/tmp" logdir "/tmp/log") istab)

(run-test)

; vim: ft=arc