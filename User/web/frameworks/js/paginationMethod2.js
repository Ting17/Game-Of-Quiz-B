function Pager(tableName, itemsPerPage) {
    this.tableName = tableName;
    this.itemsPerPage = itemsPerPage;
    this.currentPage = 1;
    this.pages = 0;
    this.inited = false;
    this.rows = document.getElementById(tableName).rows;
    this.records = (this.rows.length - 1);
    
    this.init = function() {
        this.pages = Math.ceil(this.records / itemsPerPage);
        this.inited = true;
    };
    
    this.showRecords = function(from, to) {
        var rows = document.getElementById(tableName).rows;
        // i starts from 1 to skip table header row
        for (var i = 1; i < rows.length; i++) {
            if (i < from || i > to)
                rows[i].style.display = 'none';
            else
                rows[i].style.display = '';
        }
    };

    this.showPage = function(pageNumber) {
        if (! this.inited) {
            alert("not inited");
            return;
        }

        var oldPage = document.getElementById('pg'+this.currentPage);
        oldPage.className = 'pg-normal';
        
        this.currentPage = pageNumber;
        var newPage = document.getElementById('pg'+this.currentPage);
        newPage.className = 'pg-selected';
        
        var from = (pageNumber - 1) * itemsPerPage + 1;
        var to = from + itemsPerPage - 1;
        this.showRecords(from, to);
    };
    
     this.pagination = function(pagerName2, pgNum2) {
        if (! this.inited) {
            alert("not inited");
            return;
        }

        var element = document.getElementById(pgNum2);
        var pagerHtml = '<span onclick="' + pagerName2 + '.prev();" class="pg-normal"> « Prev </span> | ';
            for (var page = 1; page <= this.pages; page++) 
               pagerHtml += '<span id="pg' + page + '" class="pg-normal" onclick="' + pagerName2 + '.showPage(' + page + ');">' + page + '</span> | ';
            pagerHtml += '<span onclick="'+pagerName2+'.next();" class="pg-normal"> Next »</span>';            

            element.innerHTML = pagerHtml;
    };
}


