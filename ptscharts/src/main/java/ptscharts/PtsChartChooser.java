/*********************************************************************
 * File path:     /share/pts/ptscharts/src/main/java/ptscharts/PtsChartChooser.java
 * Version:       
 * Description:   
 * Author:        Rick Charon <rickcharon@gmail.com>
 * Created at:    Wed Nov 24 12:10:02 2010
 * Modified at:   Fri Jul  4 14:25:42 2014
 ********************************************************************/

/*
 * ChartsForm.java
 *
 * Created on Apr 2, 2010, 5:19:20 AM
 */
package ptscharts;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Set;
import java.util.Vector;
import java.util.concurrent.BlockingQueue;
import javax.swing.JList;
import org.joda.time.DateTime;
import ptsutils.PtsDBops;
import ptsutils.PtsSymbolInfos;
//import petrasys.utils.Classes;
//import petrasys.utils.DBops;
//import petrasys.utils.DateOps;
//import petrasys.utils.MsgBox;
//import petrasys.utils.ReportFrame;

/**
 *
 * @author rickcharon
 */
public class PtsChartChooser extends javax.swing.JFrame {

  java.awt.Image appIcon = this.getToolkit().createImage("/share/icons/line-chart.png");
  //private ReportFrame reportFrame;
  private BlockingQueue<String> reportQueue;
  SimpleDateFormat dateStrFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
  private List<Class> indicatorsList;

//  private class symbolInfo {
//
//    String symbol;
//    String exchange;
//    int multiplier;
//    int priceMagnifier;
//    double minTick;
//    String fullName;
//  };
//  //HashMap symbolInfos;
//  symbolInfo workingSI;
  private Vector<String> symbols;
  PtsSymbolInfos syminfs;
  PtsChartFactory factory;

  public Vector<String> getSymbols() {
    return symbols;
  }

  public JList getSymbolsList() {
    return symbolsList;
  }

  private void initLists() {
    //getDistinctSymbolInfos();
    getDistinctSymbolNames();
    //populateIndicators();

  }

  /** Creates new form ChartsForm */
  public PtsChartChooser() {
    symbols = new Vector();
    syminfs = new PtsSymbolInfos();
    syminfs.getDistinctSymbolInfos();
    factory = new PtsChartFactory(syminfs);
    setIconImage(appIcon);
    //symbolInfos = new HashMap();
    initLists();
    initComponents();
  }

  public void getDistinctSymbolNames() {
    Set syms = syminfs.getSymInfos().keySet();
    syms.stream().forEach((s) -> {
      symbols.add(s.toString());
    });
  }

  public DateTime getBeginDate() {
    DateTime dt = new DateTime(beginDateChooser.getCalendar());
    return dt;
  }

  public void setBeginDate(String beginDt) {
    Calendar c = new GregorianCalendar();
    DateTime bdt = new DateTime(beginDt);
    beginDateChooser.setCalendar(bdt.toCalendar(null));
  }

  public DateTime getEndDate() {
    DateTime dt = new DateTime(endDateChooser.getCalendar());
    return dt;
  }

  public void setEndDate(String endDt) {
    Calendar c = new GregorianCalendar();
    DateTime bdt = new DateTime(endDt);
    endDateChooser.setCalendar(bdt.toCalendar(null));
  }

  public void setSelectedSymbol(String symIn) {
    symbolsList.setSelectedValue(symIn, true);
  }

  public void setCompressionFactor(int factorIn) {
    priceBarCompressionText.setText(Integer.toString(factorIn));
  }

  /** This method is called from within the constructor to
   * initialize the form.
   * WARNING: Do NOT modify this code. The content of this method is
   * always regenerated by the Form Editor.
   */
  @SuppressWarnings("unchecked")
  // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
  private void initComponents() {

    jComboBox1 = new javax.swing.JComboBox();
    jLabel1 = new javax.swing.JLabel();
    jScrollPane1 = new javax.swing.JScrollPane();
    symbolsList = new javax.swing.JList(symbols);
    jLabel5 = new javax.swing.JLabel();
    beginDateLabel = new javax.swing.JLabel();
    jLabel3 = new javax.swing.JLabel();
    endDateLabel = new javax.swing.JLabel();
    jLabel6 = new javax.swing.JLabel();
    beginDateChooser = new com.toedter.calendar.JDateChooser();
    jLabel2 = new javax.swing.JLabel();
    endDateChooser = new com.toedter.calendar.JDateChooser();
    createChartButton = new javax.swing.JButton();
    priceBarsCompressionPanel2 = new javax.swing.JPanel();
    priceBarCompressionText = new javax.swing.JTextField();
    jLabel12 = new javax.swing.JLabel();
    jLabel13 = new javax.swing.JLabel();
    exitButton = new javax.swing.JButton();
    jCheckBox1 = new javax.swing.JCheckBox();
    jCheckBox2 = new javax.swing.JCheckBox();

    jComboBox1.setModel(new javax.swing.DefaultComboBoxModel(new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));

    setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
    setTitle("PeTraSys - Charts");
    addWindowListener(new java.awt.event.WindowAdapter() {
      public void windowClosing(java.awt.event.WindowEvent evt) {
        formWindowClosing(evt);
      }
      public void windowOpened(java.awt.event.WindowEvent evt) {
        formWindowOpened(evt);
      }
    });

    jLabel1.setFont(new java.awt.Font("DejaVu Sans", 1, 14)); // NOI18N
    java.util.ResourceBundle bundle = java.util.ResourceBundle.getBundle("petrasys/Bundle"); // NOI18N
    jLabel1.setText(bundle.getString("PeTraSysTopFrame1.jLabel1.text")); // NOI18N

    symbolsList.setFont(new java.awt.Font("DejaVu Sans", 1, 14)); // NOI18N
    symbolsList.setModel(new javax.swing.AbstractListModel() {
      public int getSize() { return symbols.size(); }
      public Object getElementAt(int i) { return symbols.elementAt(i); }
    });
    symbolsList.setSelectionMode(javax.swing.ListSelectionModel.SINGLE_SELECTION);
    symbolsList.addListSelectionListener(new javax.swing.event.ListSelectionListener() {
      public void valueChanged(javax.swing.event.ListSelectionEvent evt) {
        symbolsListValueChanged(evt);
      }
    });
    jScrollPane1.setViewportView(symbolsList);

    jLabel5.setFont(new java.awt.Font("DejaVu Sans", 1, 14)); // NOI18N
    jLabel5.setText(bundle.getString("PeTraSysTopFrame1.jLabel5.text")); // NOI18N

    beginDateLabel.setFont(new java.awt.Font("DejaVu Sans", 1, 16)); // NOI18N
    beginDateLabel.setText(bundle.getString("PeTraSysTopFrame1.beginDateLabel.text")); // NOI18N

    jLabel3.setFont(new java.awt.Font("DejaVu Sans", 1, 14)); // NOI18N
    jLabel3.setText(bundle.getString("PeTraSysTopFrame1.jLabel3.text")); // NOI18N

    endDateLabel.setFont(new java.awt.Font("DejaVu Sans", 1, 16)); // NOI18N
    endDateLabel.setText(bundle.getString("PeTraSysTopFrame1.endDateLabel.text")); // NOI18N

    jLabel6.setFont(new java.awt.Font("DejaVu Sans", 1, 14)); // NOI18N
    jLabel6.setText(bundle.getString("PeTraSysTopFrame1.jLabel6.text")); // NOI18N

    beginDateChooser.setDateFormatString("MM/dd/yyyy HH:mm:ss");
    beginDateChooser.setDoubleBuffered(false);
    beginDateChooser.setFont(new java.awt.Font("DejaVu Sans", 0, 18)); // NOI18N
    beginDateChooser.setName("beginDateChooser"); // NOI18N
    //beginDateChooser.setVisible(false);

    jLabel2.setFont(new java.awt.Font("DejaVu Sans", 1, 14)); // NOI18N
    jLabel2.setText(bundle.getString("PeTraSysTopFrame1.jLabel2.text")); // NOI18N

    endDateChooser.setDateFormatString("MM/dd/yyyy HH:mm:ss");
    endDateChooser.setFont(new java.awt.Font("DejaVu Sans", 0, 18)); // NOI18N
    //endDateChooser.setVisible(false);

    createChartButton.setFont(new java.awt.Font("DejaVu Sans", 0, 18)); // NOI18N
    createChartButton.setText("Create Chart");
    createChartButton.addActionListener(new java.awt.event.ActionListener() {
      public void actionPerformed(java.awt.event.ActionEvent evt) {
        createChartButtonActionPerformed(evt);
      }
    });

    priceBarsCompressionPanel2.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));
    priceBarsCompressionPanel2.setFont(new java.awt.Font("DejaVu Sans", 1, 14)); // NOI18N

    priceBarCompressionText.setFont(new java.awt.Font("DejaVu Sans", 1, 14)); // NOI18N
    priceBarCompressionText.setHorizontalAlignment(javax.swing.JTextField.RIGHT);
    priceBarCompressionText.setText(bundle.getString("PeTraSysTopFrame1.priceBarCompressionFactor.text")); // NOI18N

    jLabel12.setFont(new java.awt.Font("DejaVu Sans", 1, 14)); // NOI18N
    jLabel12.setText(bundle.getString("PeTraSysTopFrame1.jLabel9.text")); // NOI18N

    jLabel13.setFont(new java.awt.Font("DejaVu Sans", 1, 14)); // NOI18N
    jLabel13.setText(bundle.getString("PeTraSysTopFrame1.jLabel8.text")); // NOI18N

    javax.swing.GroupLayout priceBarsCompressionPanel2Layout = new javax.swing.GroupLayout(priceBarsCompressionPanel2);
    priceBarsCompressionPanel2.setLayout(priceBarsCompressionPanel2Layout);
    priceBarsCompressionPanel2Layout.setHorizontalGroup(
      priceBarsCompressionPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(priceBarsCompressionPanel2Layout.createSequentialGroup()
        .addGroup(priceBarsCompressionPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
          .addGroup(priceBarsCompressionPanel2Layout.createSequentialGroup()
            .addGap(91, 91, 91)
            .addGroup(priceBarsCompressionPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
              .addComponent(jLabel12)
              .addComponent(priceBarCompressionText, javax.swing.GroupLayout.PREFERRED_SIZE, 82, javax.swing.GroupLayout.PREFERRED_SIZE)))
          .addComponent(jLabel13))
        .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
    );
    priceBarsCompressionPanel2Layout.setVerticalGroup(
      priceBarsCompressionPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(priceBarsCompressionPanel2Layout.createSequentialGroup()
        .addComponent(jLabel13)
        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
        .addComponent(jLabel12)
        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
        .addComponent(priceBarCompressionText, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
        .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
    );

    exitButton.setFont(new java.awt.Font("DejaVu Sans", 0, 18)); // NOI18N
    exitButton.setText("Exit Program");
    exitButton.addActionListener(new java.awt.event.ActionListener() {
      public void actionPerformed(java.awt.event.ActionEvent evt) {
        exitButtonActionPerformed(evt);
      }
    });

    jCheckBox1.setText("Show Paper Trades");

    jCheckBox2.setText("Show Sent Trades");

    javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
    getContentPane().setLayout(layout);
    layout.setHorizontalGroup(
      layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(layout.createSequentialGroup()
        .addContainerGap()
        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
          .addComponent(jLabel1)
          .addGroup(layout.createSequentialGroup()
            .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 69, javax.swing.GroupLayout.PREFERRED_SIZE)
            .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
              .addGroup(layout.createSequentialGroup()
                .addGap(13, 13, 13)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                  .addComponent(jLabel5)
                  .addComponent(jLabel3)
                  .addComponent(beginDateLabel, javax.swing.GroupLayout.DEFAULT_SIZE, 226, Short.MAX_VALUE)
                  .addComponent(endDateLabel, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
              .addGroup(layout.createSequentialGroup()
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(priceBarsCompressionPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))))
        .addGap(41, 41, 41)
        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
          .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
            .addGroup(layout.createSequentialGroup()
              .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                .addGroup(layout.createSequentialGroup()
                  .addGap(33, 33, 33)
                  .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 200, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGroup(layout.createSequentialGroup()
                  .addGap(23, 23, 23)
                  .addComponent(jLabel6, javax.swing.GroupLayout.PREFERRED_SIZE, 210, javax.swing.GroupLayout.PREFERRED_SIZE)))
              .addGap(225, 225, 225))
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
              .addGroup(layout.createSequentialGroup()
                .addComponent(endDateChooser, javax.swing.GroupLayout.PREFERRED_SIZE, 270, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 51, Short.MAX_VALUE)
                .addComponent(exitButton))
              .addGroup(layout.createSequentialGroup()
                .addComponent(beginDateChooser, javax.swing.GroupLayout.PREFERRED_SIZE, 269, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(createChartButton))))
          .addComponent(jCheckBox1)
          .addComponent(jCheckBox2))
        .addContainerGap(57, Short.MAX_VALUE))
    );

    layout.linkSize(javax.swing.SwingConstants.HORIZONTAL, new java.awt.Component[] {jCheckBox1, jCheckBox2});

    layout.setVerticalGroup(
      layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(layout.createSequentialGroup()
        .addContainerGap()
        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
          .addGroup(layout.createSequentialGroup()
            .addGap(94, 94, 94)
            .addComponent(endDateChooser, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)
            .addGap(18, 18, 18)
            .addComponent(jCheckBox1, javax.swing.GroupLayout.PREFERRED_SIZE, 44, javax.swing.GroupLayout.PREFERRED_SIZE)
            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
            .addComponent(jCheckBox2, javax.swing.GroupLayout.PREFERRED_SIZE, 45, javax.swing.GroupLayout.PREFERRED_SIZE))
          .addGroup(layout.createSequentialGroup()
            .addComponent(jLabel1)
            .addGap(6, 6, 6)
            .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
              .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 227, javax.swing.GroupLayout.PREFERRED_SIZE)
              .addGroup(layout.createSequentialGroup()
                .addComponent(jLabel5)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(beginDateLabel)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jLabel3)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(endDateLabel)
                .addGap(31, 31, 31)
                .addComponent(priceBarsCompressionPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))))
          .addGroup(layout.createSequentialGroup()
            .addComponent(jLabel6)
            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
            .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
              .addComponent(beginDateChooser, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)
              .addComponent(createChartButton))
            .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
              .addGroup(layout.createSequentialGroup()
                .addGap(10, 10, 10)
                .addComponent(jLabel2))
              .addGroup(layout.createSequentialGroup()
                .addGap(39, 39, 39)
                .addComponent(exitButton)))))
        .addContainerGap(58, Short.MAX_VALUE))
    );

    pack();
  }// </editor-fold>//GEN-END:initComponents
    private void symbolsListValueChanged(javax.swing.event.ListSelectionEvent evt) {//GEN-FIRST:event_symbolsListValueChanged
      String sym = (String) symbolsList.getSelectedValue();
      try {
        ResultSet res = PtsDBops.minMaxDatesBySym2(sym).executeQuery();
        if (res.next()) {
          Timestamp minD = res.getTimestamp(1);
          Timestamp maxD = res.getTimestamp(2);
          Calendar minCal = new GregorianCalendar();
          minCal.setTime(minD);
          Calendar maxCal = new GregorianCalendar();
          maxCal.setTime(maxD);
          SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
          String beginTime = dateFormat.format(minCal.getTime());
          String endTime = dateFormat.format(maxCal.getTime());
          //beginDateChooser.setCalendar(minCal);
          //endDateChooser.setCalendar(maxCal);
          beginDateLabel.setText(PtsDateOps.dbFormatString(minD));
          endDateLabel.setText(PtsDateOps.dbFormatString(maxD));
        }
        //int i = 1;
      } catch (SQLException ex) {
        System.err.println("SQLException in symbolsListValueChanged: " + ex.getMessage());
      }
}//GEN-LAST:event_symbolsListValueChanged

    private void formWindowOpened(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_formWindowOpened
      setLocationRelativeTo(null);
    }//GEN-LAST:event_formWindowOpened

  public void createChart() {
    String sym = (String) (symbolsList.getSelectedValue());
    int cf = Integer.parseInt(priceBarCompressionText.getText().trim());
    PtsChart chart = factory.createPtsChart(sym, getBeginDate(), getEndDate(), cf);
    chart.show();
  }

    private void createChartButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_createChartButtonActionPerformed
      createChart();
    }//GEN-LAST:event_createChartButtonActionPerformed

    private void exitButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_exitButtonActionPerformed
      System.exit(0);
    }//GEN-LAST:event_exitButtonActionPerformed

    private void formWindowClosing(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_formWindowClosing
      setExtendedState(ICONIFIED);
    }//GEN-LAST:event_formWindowClosing

//    public void getDistinctSymbolInfos() {
//    try {
//      ResultSet res = PtsDBops.distinctSymbolInfos().executeQuery();
//      symbolInfos.clear();
//      symbols.clear();
//      while (res.next()) {
//        symbolInfo si = new symbolInfo();
//        si.symbol = res.getString("symbol");
//        si.exchange = res.getString("exchange");
//        si.multiplier = res.getInt("multiplier");
//        si.priceMagnifier = res.getInt("priceMagnifier");
//        si.minTick = res.getDouble("minTick");
//        si.fullName = res.getString("fullName");
//        symbolInfos.put(si.symbol, si);
//        //symbols.add(res.getString("symbol"));
//      }
//      res.close();
//    } catch (SQLException ex) {
//      Logger.getLogger(PtsChartChooser.class.getName()).log(Level.SEVERE, null, ex);
//    }
//  }
  /**
   * @param args the command line arguments
   */
  public static void main(String args[]) {
    java.awt.EventQueue.invokeLater(new Runnable() {

      public void run() {
        PtsChartChooser pcc = new PtsChartChooser();
        pcc.setBeginDate("2014-02-03T03:00");
        pcc.setEndDate("2014-02-18T07:00");
        DateTime dt = pcc.getEndDate();
        pcc.setSelectedSymbol("CAD");
        pcc.setCompressionFactor(60);
        pcc.setVisible(true);
      }
    });
  }
  // Variables declaration - do not modify//GEN-BEGIN:variables
  private com.toedter.calendar.JDateChooser beginDateChooser;
  private javax.swing.JLabel beginDateLabel;
  private javax.swing.JButton createChartButton;
  private com.toedter.calendar.JDateChooser endDateChooser;
  private javax.swing.JLabel endDateLabel;
  private javax.swing.JButton exitButton;
  private javax.swing.JCheckBox jCheckBox1;
  private javax.swing.JCheckBox jCheckBox2;
  private javax.swing.JComboBox jComboBox1;
  private javax.swing.JLabel jLabel1;
  private javax.swing.JLabel jLabel12;
  private javax.swing.JLabel jLabel13;
  private javax.swing.JLabel jLabel2;
  private javax.swing.JLabel jLabel3;
  private javax.swing.JLabel jLabel5;
  private javax.swing.JLabel jLabel6;
  private javax.swing.JScrollPane jScrollPane1;
  private javax.swing.JTextField priceBarCompressionText;
  private javax.swing.JPanel priceBarsCompressionPanel2;
  private javax.swing.JList symbolsList;
  // End of variables declaration//GEN-END:variables
}
