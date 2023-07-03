import { LightningElement, track ,api, wire } from 'lwc';
import getName from '@salesforce/apex/BookProductDetail.getName';
export default class BookDetail extends LightningElement {
@track columns = [
    { label: 'Id', fieldName: 'Id'},
    { label: 'Product Name', fieldName: 'Name' },
    { label: 'ImageUrl', fieldName: 'ImageUrl__c' },
    { label: 'Product Code', fieldName: 'ProductCode' },
    { label: 'Unit Cost', fieldName: 'Unit_Cost__c' },
    { label: 'Quantity', fieldName: 'Quantity__c' },
    { label: 'Total Cost', fieldName: '	Total_Cost__c' },
    { label: 'Product Description', fieldName: 'Description' }
  ];
  @track ProductList;
  @api disabled = false;
  @api fieldId='';
  Name = '';

  handleChange(event){
    const userInput = event.target.value;
    this.Name = userInput;
  }
  oppaction(event) {
    this.fieldId = event.target.dataset.fieldid;
    console.log('Field ID:', this.fieldId);
    console.log('Created Lead ID:', this.fieldId);
}
  @wire(getName, { Name: '$Name' })
  wiredOrder({data,error}) {
    if (data) {
      this.ProductList = data;
      console.log(data); 
    } else if (error) {
      console.log(error);
    }
  }
}