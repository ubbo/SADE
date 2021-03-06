xquery version "1.0";

import module namespace smc  = "http://clarin.eu/smc" at "smc.xqm";
import module namespace crday  = "http://aac.ac.at/content_repository/data-ay" at "../aqay/crday.xqm";
import module namespace repo-utils = "http://aac.ac.at/content_repository/utils" at  "../../core/repo-utils.xqm";
import module namespace config="http://exist-db.org/xquery/apps/config" at "/db/apps/cr-xq/core/config.xqm";
import module namespace diag =  "http://www.loc.gov/zing/srw/diagnostic/" at  "modules/diagnostics/diagnostics.xqm";

 (:  import module namespace cmdcheck  = "http://clarin.eu/cmd/check" at "/db/cr/modules/cmd/cmd-check.xqm"; :)

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace cmd = "http://www.clarin.eu/cmd/";

let $dcr-cmd-map := doc("/db/apps/cr-xq/modules/smc/data/dcr-cmd-map.xml")
let $xsl-smc-op := doc("/db/apps/cr-xq/modules/smc/xsl/smc_op.xsl")

let $format := request:get-parameter("x-format",'htmlpage'),
    $op := request:get-parameter("operation", ""),
    $mode := request:get-parameter("mode", "") (: refresh :)

let $x-context := "mdrepo",
    $config := config:config($x-context)
    let $model := map { "config" := $config}
    let $cache-path := config:param-value($model, 'cache.path')


let $result := if ($op eq '' or contains ($op, 'mappings-overview')) then                    
                    smc:mappings-overview($config, $format)
                else if ($op = 'gen-mappings') then                
                    smc:gen-mappings($config, $x-context, ($mode eq 'refresh'), 'raw') 
                else if (contains ($op, 'gen-graph')) then                    
                    smc:gen-graph($config, $x-context)
                else if (contains ($op, 'get-struct')) then                    
                    repo-utils:get-from-cache(concat($smc:structure-file,'.xml'),$config)
                 else if (contains ($op, 'get-graph')) then           
                    if ($format='json') then
                        let $option := util:declare-option("output:media-type", "text/javascript")
                        let $json-binary :=util:binary-doc(concat($cache-path,'/',$smc:structure-file,'-graph.json'))
                        let $json := util:binary-to-string($json-binary)
                        return $json
                    else 
                        repo-utils:get-from-cache(concat($smc:structure-file,'-graph.xml'),$config)
                else 
                    diag:diagnostics("unsupported-operation", $op)


return $result