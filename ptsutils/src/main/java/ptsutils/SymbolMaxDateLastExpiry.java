/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ptsutils;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.StringTokenizer;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

/**
 *
 * @author rickcharon
 */
public class SymbolMaxDateLastExpiry {

  public String symbol;
  public int expiry;
  public String exchange;
  public Date beginDateToDownload;
  public Calendar lastDateToDownload;

  public SymbolMaxDateLastExpiry() {
  }

  public static ArrayList<SymbolMaxDateLastExpiry> createContractInfosFromFile(String filePath) {
    DateTimeFormatter dtParser = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm");
    ArrayList<SymbolMaxDateLastExpiry> contractInfos = new ArrayList<SymbolMaxDateLastExpiry>();
    try {
      BufferedReader br = new BufferedReader(new FileReader(filePath));
      String strLine = "";
      StringTokenizer st = null;
      int lineNumber = 0, tokenNumber = 0;
      //read comma separated file line by line
      while ((strLine = br.readLine()) != null) {
        Character char0 = strLine.charAt(0);
        if(char0.charValue() == '#') continue;
        lineNumber++;
        SymbolMaxDateLastExpiry symt = new SymbolMaxDateLastExpiry();
        //break comma separated line using ","
        st = new StringTokenizer(strLine, ",");
        while (st.hasMoreTokens()) {
          tokenNumber++;
          symt.symbol = st.nextToken().trim();
          symt.expiry = Integer.parseInt(st.nextToken().trim());
          symt.exchange = st.nextToken().trim();
          symt.beginDateToDownload = dtParser.parseDateTime(st.nextToken().trim()).toDate();
          if (st.hasMoreTokens()) {
            symt.lastDateToDownload = dtParser.parseDateTime(st.nextToken().trim()).toCalendar(Locale.US);
          } else {
            symt.lastDateToDownload = new DateTime().toCalendar(Locale.US);
          }
          contractInfos.add(symt);
        }
        //reset token number

      }
      System.out.println(tokenNumber + " lines read from ContractInfoFile - " + filePath);
    } catch (Exception e) {
      System.err.println("Exception while reading ContractInfoFile file: " + e);
      System.err.println("Format is symbol, expiry, exchange, beginDateTime, endDateTime");
      System.err.println("EndDateTime can be omitted, format for dates is yyyy-MM-dd hh:mm");
      System.err.println("IndexOutOfBoundsException - empty chars at end of file?");
    } finally {
      return contractInfos;
    }
  }

  /**
   * 11/26/13 2:22 PM Currently just used for various tests
   * @param args - currently not used
   */
  public static void main(String[] args) {
    ArrayList<SymbolMaxDateLastExpiry> ContractInfoTable;
    ContractInfoTable = 
            SymbolMaxDateLastExpiry.createContractInfosFromFile("/share/JavaDev/teamigo/ptsupdater/testcomment.csv");
    int stopit = 1;

  }
}
