/**
 * 
 */
function pageNavigator(countPerPage, pagePerGroup, currentPage, totalRecordsCount){
		this.countPerPage = countPerPage;
		this.pagePerGroup = pagePerGroup;
		this.totalRecordsCount = totalRecordsCount;
		this.currentPage = currentPage
				
		this.totalPageCount = Math.floor((totalRecordsCount + countPerPage - 1) / countPerPage);
		if (this.currentPage < 1){
				this.currentPage = 1;
		}
		if (this.currentPage > this.totalPageCount){
			this.currentPage = this.totalPageCount;
		}
		this.currentGroup = Math.floor((currentPage - 1) / pagePerGroup);
		this.startPageGroup = this.currentGroup * this.pagePerGroup + 1;
		if(this.startPageGroup < 1){
			this.startPageGroup = 1;
		}else{
			this.startPageGroup = this.startPageGroup;
		}
		
		this.endPageGroup = this.startPageGroup + this.pagePerGroup - 1;
		
		if(this.endPageGroup < this.totalPageCount){
			this.endPageGroup = this.endPageGroup
		}else{
			this.endPageGroup = this.totalPageCount
		}
		
		this.startRecord = (this.currentPage - 1) * this.countPerPage;
			
	}
	pageNavigator.prototype.getCountPerPage = function() {
		return this.countPerPage;
	}

	pageNavigator.prototype.setCountPerPage = function(countPerPage) {
		this.countPerPage = countPerPage;
	}

	pageNavigator.prototype.getPagePerGroup = function() {
		return this.pagePerGroup;
	}

	pageNavigator.prototype.setPagePerGroup = function(pagePerGroup) {
		this.pagePerGroup = pagePerGroup;
	}

	pageNavigator.prototype.getCurrentPage = function() {
		return this.currentPage;
	}

	pageNavigator.prototype.setCurrentPage = function(currentPage) {
		this.currentPage = currentPage;
	}

	pageNavigator.prototype.getTotalRecordsCount = function() {
		return this.totalRecordsCount;
	}

	pageNavigator.prototype.setTotalRecordsCount = function(totalRecordsCount) {
		this.totalRecordsCount = totalRecordsCount;
	}

	pageNavigator.prototype.getTotalPageCount = function() {
		return this.totalPageCount;
	}

	pageNavigator.prototype.setTotalPageCount = function(totalPageCount) {
		this.totalPageCount = totalPageCount;
	}

	pageNavigator.prototype.getCurrentGroup = function() {
		return this.currentGroup;
	}

	pageNavigator.prototype.setCurrentGroup = function(currentGroup) {
		this.currentGroup = currentGroup;
	}

	pageNavigator.prototype.getStartPageGroup = function() {
		return this.startPageGroup;
	}

	pageNavigator.prototype.setStartPageGroup = function(startPageGroup) {
		this.startPageGroup = startPageGroup;
	}

	pageNavigator.prototype.getEndPageGroup = function() {
		return this.endPageGroup;
	}

	pageNavigator.prototype.setEndPageGroup = function(endPageGroup) {
		this.endPageGroup = endPageGroup;
	}

	pageNavigator.prototype.getStartRecord = function() {
		return this.startRecord;
	}

	pageNavigator.prototype.setStartRecord = function(startRecord) {
		this.startRecord = startRecord;
	}