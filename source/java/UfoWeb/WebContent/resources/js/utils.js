/**
 * disables the submitting by pressing enter in the input field
 * 
 * @param e
 *            the event
 * @return false if the enter button was pressed
 */
function isEnterKey(e) {
	var key;
	if (window.event) {
		key = window.event.keyCode; // IE
	} else {
		key = e.which; // firefox
	}
	if (key == 13) {
		return true;
	}

	return false;
}

function stopEnterKeyForText(evt) {
	var evt = (evt) ? evt : ((event) ? event : null);
	var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement
			: null);
	return !((isEnterKey(evt)) && (node.type == 'text'));
}

function getWidgetForClientId(clientId) {
	console.log(clientId);
	var id = 'widget_' + clientId.replace(/\:/g, '_');
	console.log(id);
	return PF(id);
}
