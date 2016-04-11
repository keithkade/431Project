/* jshint browser:true, devel:true */
/* global $, pageLoadTime */

/**
 * Created by kade on 4/10/16.
 * This is being included on all pages, even though it's only needed on one
 * this is harder to fix in rails than it should be
*/



function SubmitCode(code, containerId){
    var responseContainer = document.getElementById(containerId); 
    DeleteChildren(responseContainer);

    var loadingContainer = CreateElement('div', '', 'load-container');
    var spin = CreateElement('div', 'Loading...', 'loader');
    var loadingLabel = CreateElement('span', 'Evaluating...');

    loadingContainer.appendChild(spin);
    loadingContainer.appendChild(loadingLabel);
    responseContainer.appendChild(loadingContainer);
    
    //this is dirty, but I couldn't figure out the rails-y way
    var url = document.URL;
    var id = url.substr(document.URL.lastIndexOf('/') + 1, url.length);
        
    $.get('/problems/evaluate', { code: code, 
                                    id: id, 
                        startTimestamp: pageLoadTime.getTime(),
                                }, 
    function(response) {
        console.log(response);

        DeleteChildren(responseContainer);

        var status = CreateElement('div', '', 'submission-status');
        var result = CreateElement('div');

        if (response.status == "success") {
            status.innerHTML = "Code Succesfully Evaluated";
            
            var tbl = CreateElement('table');
            var cases = response.results;
            for (var i = 0; i < cases.length; i++) {
                var row = tbl.insertRow(i);
                row.insertCell(0).appendChild(document.createTextNode(cases[i].title));
                row.insertCell(1).appendChild(document.createTextNode(cases[i].result));
                row.insertCell(2).appendChild(document.createTextNode(cases[i].input));
                row.insertCell(3).appendChild(document.createTextNode(cases[i].err));
            }
            result.appendChild(tbl);
        }
        else if (response.status == "fail") {
            status.innerHTML = "Compile Error"; 
            result.innerHTML = response.err;
        }
        responseContainer.appendChild(status);
        responseContainer.appendChild(result);
    });
    
    
    function CreateElement(tagname, content, className){
        var elem = document.createElement(tagname);
        if (content) elem.innerHTML = content;
        if (className) elem.className = className;
        return elem;
    }

    /** give a list of html elements, delete all their children */ 
    function DeleteChildren() {
        for (var i = 0; i < arguments.length; i++) {
            var element = arguments[i];
            while (element.firstChild){
                element.removeChild(element.firstChild);
            }
        }
    }
}