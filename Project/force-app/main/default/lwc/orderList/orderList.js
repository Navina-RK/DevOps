import { LightningElement, track , wire, api } from 'lwc';
import getOrders from '@salesforce/apex/OrderItemList.getOrders';
import deleteOrder from '@salesforce/apex/deleteOrderRecord.deleteOrder';

const actions = [
{ label: 'Show details', name: 'show_details' },
  { label: 'Delete', name: 'delete' },
 ];

export default class OrderList extends LightningElement {
  @track columns = [
    { label: 'Id', fieldName: 'Id'},
    { label: 'Order Name', fieldName: 'Name' },
    { label: 'Quantity', fieldName: 'Quantity__c' },
    { label: 'Amount', fieldName: 'Amount__c' },
    { label: 'Total Amount', fieldName: 'Total_Amount__c' },
    { label: 'Order Status', fieldName: 'Order_Status__c' },
    { type: 'action', typeAttributes: { rowActions: actions }},
  ];

  @track orderList;
  @api orderName;

  handleChange(event){
    const userInput = event.target.value;
    this.orderName = userInput;
  }

  @wire(getOrders, { orderName: '$orderName' })
  wiredOrder({data,error}) {
    if (data) {
      this.orderList = data;
      console.log(data); 
    } else if (error) {
      console.log(error);
    }
  }

   handleDelete(event){
        const row=event.detail.row;
            this.handleDeleteRow(row.Id);
    }
    handleDeleteRow(recordIdToDelete){
        deleteOrder({orderDetailId:recordIdToDelete}).then({
        })
    }

}