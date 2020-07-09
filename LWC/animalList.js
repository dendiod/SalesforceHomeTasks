import { LightningElement, wire } from 'lwc';
import ursusResources from '@salesforce/resourceUrl/animals';
/** AnimalController.searchAnimals(searchTerm) Apex method */
import searchAnimals from '@salesforce/apex/AnimalController.searchAnimals';
export default class animalList extends LightningElement {
	searchTerm = '';
	@wire(searchAnimals, {searchTerm: '$searchTerm'})
	animals;
	appResources = {
		animalSilhouette: `${ursusResources}/doghead-question-mark.png`,
	};
	handleSearchTermChange(event) {
		// Debouncing this method: do not update the reactive property as
		// long as this function is being called within a delay of 300 ms.
		// This is to avoid a very large number of Apex method calls.
		window.clearTimeout(this.delayTimeout);
        const searchTerm = this.template.querySelector('[data-id="inputField"]').value;
        console.log(searchTerm);
		// eslint-disable-next-line @lwc/lwc/no-async-operation
		this.delayTimeout = setTimeout(() => {
			this.searchTerm = searchTerm;
		}, 300);
	}
	get hasResults() {
		return (this.animals.data.length > 0);
	}
}