/*
 * RPC 4/8/14 12:00 PM Lots of confusion about this, because it is actually called from the jFreeChart code after
 * it is set as generator in setBaseToolTipGenerator called from PtsChart.getCandlestickRenderer(). So, if you look
 * for usages, that's all you see.
 */
package ptscharts;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.util.Date;

import org.jfree.chart.HashUtilities;
import org.jfree.chart.labels.XYItemLabelGenerator;
import org.jfree.chart.labels.XYToolTipGenerator;
import org.jfree.data.xy.OHLCDataset;
import org.jfree.data.xy.XYDataset;
import org.jfree.util.PublicCloneable;

/**
 * A standard item label generator for plots that use data from a {@link OHLCDataset}.
 */
public class ToolTipGeneratorForPriceBar implements //XYItemLabelGenerator,
        XYToolTipGenerator, Cloneable, PublicCloneable, Serializable {

  /**
   * For
   * serialization.
   */
  private static final long serialVersionUID = 5617111754832211830L;
  /**
   * The date formatter.
   */
  private DateFormat dateFormatter;
  /**
   * The number formatter.
   */
  private NumberFormat numberFormatter;

  /**
   * Creates an item label generator using the default date and number formats.
   */
  public ToolTipGeneratorForPriceBar() {
    this(DateFormat.getInstance(), NumberFormat.getInstance());
  }

  /**
   * Creates a tool tip generator using the supplied date formatter.
   *
   * @param
   * dateFormatter
   * the date formatter (<code>null</code> not permitted).
   * @param
   * numberFormatter
   * the number formatter (<code>null</code> not permitted).
   */
  public ToolTipGeneratorForPriceBar(DateFormat dateFormatter,
          NumberFormat numberFormatter) {
    if (dateFormatter == null) {
      throw new IllegalArgumentException(
              "Null 'dateFormatter' argument.");
    }
    if (numberFormatter == null) {
      throw new IllegalArgumentException(
              "Null 'numberFormatter' argument.");
    }
    this.dateFormatter = dateFormatter;
    this.numberFormatter = numberFormatter;
  }

  /**
     * Generates a tooltip text item for a particular item within a series.
     *
     * @param dataset  the dataset.
     * @param series  the series (zero-based index).
     * @param item  the item (zero-based index).
     *
     * @return The tooltip text.
     * RPC 7/24/13 8:55 AM Originally copied from 
     * /share/JavaDev/teamigo/jfreechart/src/main/java/org/jfree/chart/labels/HighLowItemLabelGenerator.java
     * and modified.
     */
   
  public String generateToolTip(XYDataset dataset, int series, int item) {

    String result = null;

    if (dataset instanceof OHLCDataset) {
      OHLCDataset d = (OHLCDataset) dataset;
      Number high = d.getHigh(series, item);
      Number low = d.getLow(series, item);
      Number open = d.getOpen(series, item);
      Number close = d.getClose(series, item);
      Number x = d.getX(series, item);
      
      result = "<html>"; //d.getSeriesKey(series).toString();

      if (x != null) {
        Date date = new Date(x.longValue());
        result = result + "Date=" + this.dateFormatter.format(date) + "<br/>";
        if (high != null) {
          result = result + "High="
                  + this.numberFormatter.format(high.doubleValue()) + "<br/>";
        }
        if (low != null) {
          result = result + "Low="
                  + this.numberFormatter.format(low.doubleValue()) + "<br/>";
        }
        if (open != null) {
          result = result + "Open="
                  + this.numberFormatter.format(open.doubleValue()) + "<br/>";
        }
        if (close != null) {
          result = result + "Close="
                  + this.numberFormatter.format(close.doubleValue()) + "<br/>";
        }
        if ((high != null) && (low != null)) {
          result = result + "Range = " 
                  + this.numberFormatter.format(high.doubleValue() - low.doubleValue()) + "<br/>";              
        }
      }

    }
    result = result + "</html>";
    return result;

  }

  /**
   * Generates a label for the specified item. The label is typically a formatted version of the data value,
   * but any text can be used.
   *
   * @param
   * dataset the dataset (<code>null</code> not permitted).
   * @param series the
   * series index (zero-based).
   * @param
   * category the category index (zero-based).
   *
   * @return
   * The label (possibly <code>null</code>).
   */
//  public String generateLabel(XYDataset dataset, int series, int category) {
//    return null;   implement this method properly
//  }

  /**
   * Returns an independent copy of the generator.
   *
   * @return
   * A clone.
   *
   * @throws
   * CloneNotSupportedException
   * if cloning is not
   * supported.
   */
  @Override
  public Object clone() throws CloneNotSupportedException {

    ToolTipGeneratorForPriceBar clone = (ToolTipGeneratorForPriceBar) super.clone();

    if (this.dateFormatter != null) {
      clone.dateFormatter = (DateFormat) this.dateFormatter.clone();
    }
    if (this.numberFormatter != null) {
      clone.numberFormatter = (NumberFormat) this.numberFormatter.clone();
    }

    return clone;

  }

  /**
   * Tests if this object is equal to another.
   *
   * @param
   * obj
   * the other object.
   *
   * @return
   * A boolean.
   */
  @Override
  public boolean equals(Object obj) {
    if (obj == this) {
      return true;
    }
    if (!(obj instanceof ToolTipGeneratorForPriceBar)) {
      return false;
    }
    ToolTipGeneratorForPriceBar generator = (ToolTipGeneratorForPriceBar) obj;
    if (!this.dateFormatter.equals(generator.dateFormatter)) {
      return false;
    }
    if (!this.numberFormatter.equals(generator.numberFormatter)) {
      return false;
    }
    return true;
  }

  /**
   * Returns a hash code for this instance.
   *
   * @return
   * A hash code.
   */
  @Override
  public int hashCode() {
    int result = 127;
    result = HashUtilities.hashCode(result, this.dateFormatter);
    result = HashUtilities.hashCode(result, this.numberFormatter);
    return result;
  }
}
