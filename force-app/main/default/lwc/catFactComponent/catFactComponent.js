import { LightningElement, wire } from 'lwc';
import getCatFact from '@salesforce/apex/AccountController.getCatFact';

export default class CatFactComponent extends LightningElement {
    catFact;
    error;

    @wire(getCatFact)
    wiredCatFact({ error, data }) {
        if (data) {
            this.catFact = JSON.stringify(data);
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.catFact = undefined;
        }
    }
}
