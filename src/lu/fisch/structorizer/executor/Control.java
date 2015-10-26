/*
    Structorizer
    A little tool which you can use to create Nassi-Schneiderman Diagrams (NSD)

    Copyright (C) 2009  Bob Fisch

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or any
    later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

package lu.fisch.structorizer.executor;

import java.awt.Color;
import java.util.Vector;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author robertfisch
 */
public class Control extends javax.swing.JFrame {

    /** Creates new form Control */
    public Control() {
        initComponents();
        this.setDefaultCloseOperation(Control.DO_NOTHING_ON_CLOSE);
    }

    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        slSpeed = new javax.swing.JSlider();
        lblSpeed = new javax.swing.JLabel();
        btnStop = new javax.swing.JButton();
        btnPlay = new javax.swing.JButton();
        btnPause = new javax.swing.JButton();
        btnStep = new javax.swing.JButton();
        jScrollPane1 = new javax.swing.JScrollPane();
        tblVar = new javax.swing.JTable();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        slSpeed.setMajorTickSpacing(100);
        slSpeed.setMaximum(2000);
        slSpeed.addMouseMotionListener(new java.awt.event.MouseMotionAdapter() {
            public void mouseMoved(java.awt.event.MouseEvent evt) {
                slSpeedMouseMoved(evt);
            }
            public void mouseDragged(java.awt.event.MouseEvent evt) {
                slSpeedMouseDragged(evt);
            }
        });
        slSpeed.addPropertyChangeListener(new java.beans.PropertyChangeListener() {
            public void propertyChange(java.beans.PropertyChangeEvent evt) {
                slSpeedPropertyChange(evt);
            }
        });
        slSpeed.addInputMethodListener(new java.awt.event.InputMethodListener() {
            public void inputMethodTextChanged(java.awt.event.InputMethodEvent evt) {
            }
            public void caretPositionChanged(java.awt.event.InputMethodEvent evt) {
                slSpeedCaretPositionChanged(evt);
            }
        });
        slSpeed.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseReleased(java.awt.event.MouseEvent evt) {
                slSpeedMouseReleased(evt);
            }
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                slSpeedMouseClicked(evt);
            }
            public void mouseExited(java.awt.event.MouseEvent evt) {
                slSpeedMouseExited(evt);
            }
        });
        slSpeed.addMouseWheelListener(new java.awt.event.MouseWheelListener() {
            public void mouseWheelMoved(java.awt.event.MouseWheelEvent evt) {
                slSpeedMouseWheelMoved(evt);
            }
        });

        lblSpeed.setHorizontalAlignment(javax.swing.SwingConstants.LEFT);
        lblSpeed.setText(" Speed: 50");

        btnStop.setIcon(new javax.swing.ImageIcon(getClass().getResource("/lu/fisch/structorizer/executor/stop.png"))); // NOI18N
        btnStop.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnStopActionPerformed(evt);
            }
        });

        btnPlay.setIcon(new javax.swing.ImageIcon(getClass().getResource("/lu/fisch/structorizer/executor/play.png"))); // NOI18N
        btnPlay.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnPlayActionPerformed(evt);
            }
        });

        btnPause.setIcon(new javax.swing.ImageIcon(getClass().getResource("/lu/fisch/structorizer/executor/pause.png"))); // NOI18N
        btnPause.setEnabled(false);
        btnPause.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnPauseActionPerformed(evt);
            }
        });

        btnStep.setIcon(new javax.swing.ImageIcon(getClass().getResource("/lu/fisch/structorizer/executor/next.png"))); // NOI18N
        btnStep.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnStepActionPerformed(evt);
            }
        });

        tblVar.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "Name", "Content"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.String.class, java.lang.Object.class
            };

            public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
            }
        });
        jScrollPane1.setViewportView(tblVar);

        org.jdesktop.layout.GroupLayout layout = new org.jdesktop.layout.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(layout.createSequentialGroup()
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(lblSpeed, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 86, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(layout.createSequentialGroup()
                        .add(btnStop)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(btnPlay)))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(layout.createSequentialGroup()
                        .add(btnPause)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(btnStep))
                    .add(slSpeed, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 83, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))
            .add(jScrollPane1, 0, 0, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(layout.createSequentialGroup()
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.TRAILING, false)
                    .add(lblSpeed, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 28, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(slSpeed, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(btnStop)
                    .add(btnPlay)
                    .add(btnPause)
                    .add(btnStep))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jScrollPane1, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 236, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    public void init()
    {
        btnStop.setEnabled(true);
        btnPlay.setEnabled(true);
        btnPause.setEnabled(false);
        btnStep.setEnabled(true);
        // emtpy table
        DefaultTableModel tm = (DefaultTableModel) tblVar.getModel();
        while(tm.getRowCount()>0) tm.removeRow(0);
    }

    private void btnStopActionPerformed(java.awt.event.ActionEvent evt)//GEN-FIRST:event_btnStopActionPerformed
    {//GEN-HEADEREND:event_btnStopActionPerformed
        Executor.getInstance().setStop(true);
        this.setVisible(false);
    }//GEN-LAST:event_btnStopActionPerformed

    private void btnPlayActionPerformed(java.awt.event.ActionEvent evt)//GEN-FIRST:event_btnPlayActionPerformed
    {//GEN-HEADEREND:event_btnPlayActionPerformed
        btnPause.setEnabled(true);
        btnPlay.setEnabled(false);
        btnStep.setEnabled(false);
        if(Executor.getInstance().isRunning()==false)
        {
            Executor.getInstance().start(false);
        }
        else
        {
            Executor.getInstance().setPaus(false);
        }
    }//GEN-LAST:event_btnPlayActionPerformed

    private void btnPauseActionPerformed(java.awt.event.ActionEvent evt)//GEN-FIRST:event_btnPauseActionPerformed
    {//GEN-HEADEREND:event_btnPauseActionPerformed
        btnPause.setEnabled(false);
        btnPlay.setEnabled(true);
        btnStep.setEnabled(true);
        Executor.getInstance().setPaus(!Executor.getInstance().getPaus());
    }//GEN-LAST:event_btnPauseActionPerformed

    private void btnStepActionPerformed(java.awt.event.ActionEvent evt)//GEN-FIRST:event_btnStepActionPerformed
    {//GEN-HEADEREND:event_btnStepActionPerformed
        if(Executor.getInstance().isRunning()==false)
        {
            Executor.getInstance().start(true);
        }
        else
        {
            Executor.getInstance().doStep();
        }
    }//GEN-LAST:event_btnStepActionPerformed

    private void updateSpeed()
    {
        if(Executor.getInstance()!=null)
        {
            Executor.getInstance().setDelay(slSpeed.getValue());
        }
        // FIXED KGU 2010-10-14 Misleading caption "Speed" --> "Delay"
        lblSpeed.setText(" Delay: "+slSpeed.getValue());
    }

    private void slSpeedCaretPositionChanged(java.awt.event.InputMethodEvent evt)//GEN-FIRST:event_slSpeedCaretPositionChanged
    {//GEN-HEADEREND:event_slSpeedCaretPositionChanged
        updateSpeed();
    }//GEN-LAST:event_slSpeedCaretPositionChanged

    private void slSpeedPropertyChange(java.beans.PropertyChangeEvent evt)//GEN-FIRST:event_slSpeedPropertyChange
    {//GEN-HEADEREND:event_slSpeedPropertyChange
        updateSpeed();
    }//GEN-LAST:event_slSpeedPropertyChange

    private void slSpeedMouseClicked(java.awt.event.MouseEvent evt)//GEN-FIRST:event_slSpeedMouseClicked
    {//GEN-HEADEREND:event_slSpeedMouseClicked
        // TODO add your handling code here:
    }//GEN-LAST:event_slSpeedMouseClicked

    private void slSpeedMouseExited(java.awt.event.MouseEvent evt)//GEN-FIRST:event_slSpeedMouseExited
    {//GEN-HEADEREND:event_slSpeedMouseExited
        updateSpeed();
    }//GEN-LAST:event_slSpeedMouseExited

    private void slSpeedMouseMoved(java.awt.event.MouseEvent evt)//GEN-FIRST:event_slSpeedMouseMoved
    {//GEN-HEADEREND:event_slSpeedMouseMoved
        updateSpeed();
    }//GEN-LAST:event_slSpeedMouseMoved

    private void slSpeedMouseDragged(java.awt.event.MouseEvent evt)//GEN-FIRST:event_slSpeedMouseDragged
    {//GEN-HEADEREND:event_slSpeedMouseDragged
        updateSpeed();
    }//GEN-LAST:event_slSpeedMouseDragged

    private void slSpeedMouseWheelMoved(java.awt.event.MouseWheelEvent evt)//GEN-FIRST:event_slSpeedMouseWheelMoved
    {//GEN-HEADEREND:event_slSpeedMouseWheelMoved
        // TODO add your handling code here:
    }//GEN-LAST:event_slSpeedMouseWheelMoved

    private void slSpeedMouseReleased(java.awt.event.MouseEvent evt)//GEN-FIRST:event_slSpeedMouseReleased
    {//GEN-HEADEREND:event_slSpeedMouseReleased
        updateSpeed();
    }//GEN-LAST:event_slSpeedMouseReleased

    public void updateVars(Vector<Vector> vars)
    {
        tblVar.setGridColor(Color.LIGHT_GRAY);
        tblVar.setShowGrid(true);
        DefaultTableModel tm = (DefaultTableModel) tblVar.getModel();
        // emtpy table
        while(tm.getRowCount()>0) tm.removeRow(0);
        for(int i=0;i<vars.size();i++) tm.addRow(vars.get(i));
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnPause;
    private javax.swing.JButton btnPlay;
    private javax.swing.JButton btnStep;
    private javax.swing.JButton btnStop;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JLabel lblSpeed;
    private javax.swing.JSlider slSpeed;
    private javax.swing.JTable tblVar;
    // End of variables declaration//GEN-END:variables

}