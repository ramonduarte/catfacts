// opportunityList.js
import { LightningElement, api, wire } from 'lwc';
import getOpportunities from '@salesforce/apex/AccountController.getOpportunities';

const COLUMNS = [
    { label: 'Name', fieldName: 'Name', type: 'text' },
    { label: 'Close Date', fieldName: 'CloseDate', type: 'date' },
    { label: 'Amount', fieldName: 'Amount', type: 'currency', typeAttributes: { currencyCode: 'USD' } }
];

export default class OpportunityList extends LightningElement {
    @api recordId;
    opportunities;
    error;

    columns = COLUMNS;

    @wire(getOpportunities, { accountId: '$recordId' })
    wiredOpportunities({ error, data }) {
        if (data) {
            this.opportunities = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.opportunities = undefined;
        }
    }
}
