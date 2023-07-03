public class EmailJobPosterSchedule implements Schedulable {
public void execute(SchedulableContext sc)
    {
        EmailJobPosterBatch b = new EmailJobPosterBatch();
        database.executebatch(b,200);
    }
}