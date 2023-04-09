module controller

import vweb

struct DocsController {
	vweb.Context
}

pub fn new_docs_controller() &DocsController {
	docs_controller := DocsController{}
	return &docs_controller
}

['/']
pub fn (mut docs DocsController) index() vweb.Result {
	return docs.text('documentation for vserver')
}
