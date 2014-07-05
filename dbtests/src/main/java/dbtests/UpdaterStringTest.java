
// <2014-07-02 Wed 06:40> Get the updater string right and test its time.

package dbtests;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.joda.time.DateTime;
import ptscharts.PtsChart;
import ptscharts.PtsChartFactory;
import ptsutils.PtsDBops;
import ptsutils.PtsSymbolInfos;

/**
 *
 * @author rickcharon
 */
public class UpdaterStringTest {

  private PreparedStatement stmtForQuotes;
  private Connection quotes1minConnection;

  public void buildAndSendString() {
    try {
      quotes1minConnection = PtsDBops.setuptradesConnection();
      // stmtForQuotes = quotes1minConnection.prepareStatement(
      //                                                       "INSERT INTO quotes1min VALUES (?, ? , ?, ?, ?, ?, ?, ?)");
      // stmtForQuotes = quotes1minConnection.prepareStatement(
      //                                                       "select upsertquoterow(?, ? , ?, ?, ?, ?, ?, ?)");

      stmtForQuotes = quotes1minConnection.prepareCall("{ call  upsertquoterow(?, ? , ?, ?, ?, ?, ?, ?) }" );

        
      // <2014-07-02 Wed 14:14> A row not currently in db for testing. See /share/sql/upsertquoterow.sql.
      //select upsertquoterow('AUD', 20140915, '2014-06-27 14:00:00', 0.9374, 0.9375, 0.9374, 0.9375, 2);
      DateTime dt = new DateTime("2014-07-04T14:00");
      Timestamp ts = new Timestamp(dt.getMillis());
      stmtForQuotes.setString(1, "AUD");
      stmtForQuotes.setInt(2, 20140915);
      stmtForQuotes.setTimestamp(3, (Timestamp)ts);
      stmtForQuotes.setDouble(4, 0.9374);
      stmtForQuotes.setDouble(5, 0.9375);
      stmtForQuotes.setDouble(6, 0.9374);
      stmtForQuotes.setDouble(7, 0.9375);
      stmtForQuotes.setLong(8, 2);
      // String sym = "AUD";
      // String callStr = "select upsertquoterow('" + sym + "')";
      // stmtForQuotes = quotes1minConnection.prepareCall(callStr);
      // ResultSet res = stmtForQuotes.executeQuery();

      // stmtForQuotes = quotes1minConnection.prepareStatement
      //   ("select  upsertquoterow1(\'AUD\');");
      //         // ("select  upsertquoterow1(\'AUD\', 20140915, \'2014-06-27 14:00:00\', 0.9374, 0.9375, 0.9374, 0.9375, 2);");
      stmtForQuotes.addBatch();
      int[] updateCounts = stmtForQuotes.executeBatch();
      System.out.println("rows executed: " + updateCounts);
      stmtForQuotes.close();
      quotes1minConnection.close();
    } catch (SQLException sqlex) {
      System.err.println("SQLException: " + sqlex.getMessage());
    }
  }




  /**
   * @param args the command line arguments
   */
  public static void main(String[] args) {

    // long startTime;
    // startTime = System.nanoTime();
    UpdaterStringTest dbt = new UpdaterStringTest();
    dbt.buildAndSendString();
    // long stopTime = System.nanoTime();
    // long elapsedTime = stopTime - startTime;
    // System.out.println(elapsedTime);
    // double seconds = (double) elapsedTime / 1000000000.0;
    // System.out.println(seconds + " secs. for getDistinctSymbolInfos." );

    // startTime = System.nanoTime();

    // stopTime = System.nanoTime();
    // elapsedTime = stopTime - startTime;
    // System.out.println(elapsedTime);
    // seconds = (double) elapsedTime / 1000000000.0;
    // System.out.println(seconds + " secs. for factory creation." );

    // DateTime dt1 = new DateTime(2014, 1, 1, 0, 0, 0, 0);
    // DateTime dt2 = new DateTime(2014, 6, 27, 0, 0, 0, 0);

    // startTime = System.nanoTime();
    // PtsChart clhourly = factory.createPtsChart("CL", dt1.toString(), dt2.toString(), 60);
    // stopTime = System.nanoTime();
    // elapsedTime = stopTime - startTime;
    // System.out.println(elapsedTime);
    // seconds = (double) elapsedTime / 1000000000.0;
    // System.out.println(seconds + " secs. chart creation." );
  } 
}

