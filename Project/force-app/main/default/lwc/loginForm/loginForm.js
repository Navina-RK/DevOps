import { LightningElement, track } from 'lwc';

export default class LoginForm extends LightningElement {
    @track disableChildList = false;
    @track oppId = '';
    fieldId = '';

    handleSuccess(event) {
        this.fieldId = event.detail.id;
        console.log('Created Lead ID:', this.fieldId);
    }
}