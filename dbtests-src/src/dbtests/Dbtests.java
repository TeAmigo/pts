/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbtests;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
public class Dbtests {

  /**
   * @param args the command line arguments
   */
  public static void main(String[] args) {
      long startTime;
      ArrayList symbols = new ArrayList();
      PtsSymbolInfos syminfs = new PtsSymbolInfos();
      
      startTime = System.nanoTime();
      syminfs.getDistinctSymbolInfos();
      long stopTime = System.nanoTime();
      long elapsedTime = stopTime - startTime;
      System.out.println(elapsedTime);
      double seconds = (double) elapsedTime / 1000000000.0;
      System.out.println(seconds + " secs. for getDistinctSymbolInfos." );
      PtsChartFactory factory;
      startTime = System.nanoTime();
      factory = new PtsChartFactory(syminfs);
      stopTime = System.nanoTime();
      elapsedTime = stopTime - startTime;
      System.out.println(elapsedTime);
      double seconds = (double) elapsedTime / 1000000000.0;
      System.out.println(seconds + " secs. for factory creation." );

      DateTime dt = new DateTime(2011, 2, 15, 0, 0, 0, 0);

      startTime = System.nanoTime();
      PtsChart clhourly = factory.createPtsChart("CL", dt.toString(), dt.plusWeeks(2).toString(), 60);
      stopTime = System.nanoTime();
      elapsedTime = stopTime - startTime;
      System.out.println(elapsedTime);
      double seconds = (double) elapsedTime / 1000000000.0;
      System.out.println(seconds + " secs. chart creation." );
    } 
  }

