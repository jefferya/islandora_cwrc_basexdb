(: 
*
* test chronstruct contains bibcit - biography/writing/events - check bibcit 
*
*
:)


xquery version "3.0" encoding "utf-8";

import module namespace cwAccessibility="cwAccessibility" at "./islandora_access_control.xq";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:encoding "UTF-8";
declare option output:indent   "no";


declare variable $FEDORA_PID external := "";
declare variable $BASE_URL external := "";



(: the main section: :)
let $accessible_seq := cwAccessibility:queryAccessControl(/)[@pid=$FEDORA_PID]
let $doc_href := fn:concat($BASE_URL,'/',$accessible_seq/@pid/data())
let $doc_label := fn:string-join( ($accessible_seq/@label/data(),  $accessible_seq/@pid/data()), ' - ')
return
  <div>
    <h2 class="xquery_result">
      <a href="{$doc_href}">{$doc_label}</a>
    </h2>
    <div class="xquery_result_list">
      <ul>
      {
        (: find the researchnote elements and output  :)
        for $item in $accessible_seq//CHRONSTRUCT
        let $bibcit_descendant := $item/descendant::BIBCIT
        return
          if ( not($bibcit_descendant) ) then
            <li class="error">{$item}</li>
          else ()
      }
      </ul>
    </div>
  </div>


