/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package ibnums;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 *
 * @author rickcharon
 * rpc - 2/1/10 Added findCodeByNum NamedQuery
 */
@Entity
@Table(name = "IBcard")
@NamedQueries({
  @NamedQuery(name = "IBcard.findAll", query = "SELECT i FROM IBcard i"),
  @NamedQuery(name = "IBcard.findByNum", query = "SELECT i FROM IBcard i WHERE i.num = :num"),
  @NamedQuery(name = "IBcard.findByCode", query = "SELECT i FROM IBcard i WHERE i.code = :code"),
  @NamedQuery(name = "IBcard.findCodeByNum", query = "SELECT i.code FROM IBcard i WHERE i.num = :num")})
public class IBcard implements Serializable {
  private static final long serialVersionUID = 1L;
  @Id
  @Basic(optional = false)
  @Column(name = "num")
  private Integer num;
  @Basic(optional = false)
  @Column(name = "code")
  private String code;

  public IBcard() {
  }

  public IBcard(Integer num) {
    this.num = num;
  }

  public IBcard(Integer num, String code) {
    this.num = num;
    this.code = code;
  }

  public Integer getNum() {
    return num;
  }

  public void setNum(Integer num) {
    this.num = num;
  }

  public String getCode() {
    return code;
  }

  public void setCode(String code) {
    this.code = code;
  }

  @Override
  public int hashCode() {
    int hash = 0;
    hash += (num != null ? num.hashCode() : 0);
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof IBcard)) {
      return false;
    }
    IBcard other = (IBcard) object;
    if ((this.num == null && other.num != null) || (this.num != null && !this.num.equals(other.num))) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "ibnums.IBcard[num=" + num + "]";
  }

}
