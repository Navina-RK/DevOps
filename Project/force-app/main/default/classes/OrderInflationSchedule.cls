public class OrderInflationSchedule implements Schedulable {
public void execute(SchedulableContext sc)
    {
        OrderInflationBatch b = new OrderInflationBatch ();
        database.executebatch(b,200);
    }
}