import javax.swing.*;

import java.awt.event.*;
import java.sql.*;

public class AppGUI extends JFrame implements ActionListener {
    private final JLabel studentIdLabel, firstNameLabel, lastNameLabel, majorLabel, phoneLabel, gpaLabel, dobLabel;
    private final JTextField studentIdField, firstNameField, lastNameField, majorField, phoneField, gpaField, dobField;
    private final JButton addButton, displayButton, sortButton, searchButton, modifyButton;

    private Statement stmt;

    public AppGUI() {
        JFrame frame = new JFrame("Publishing House DBMS");
        JPanel panel = new JPanel();

        // Initialize labels
        studentIdLabel = new JLabel("Path:");
        firstNameLabel = new JLabel("Article Name:");
        lastNameLabel = new JLabel("Summary:");
        majorLabel = new JLabel("Newspaper:");
        phoneLabel = new JLabel("Leaf:");
        gpaLabel = new JLabel("Category:");
        dobLabel = new JLabel("Size:");

        // Initialize text fields
        studentIdField = new JTextField(10);
        firstNameField = new JTextField(10);
        lastNameField = new JTextField(10);
        majorField = new JTextField(10);
        phoneField = new JTextField(10);
        gpaField = new JTextField(10);
        dobField = new JTextField(10);

        // Initialize buttons
        addButton = new JButton("Add");
        displayButton = new JButton("Display");
        sortButton = new JButton("Sort");
        searchButton = new JButton("Search");
        modifyButton = new JButton("Modify");

        // Add action listeners to buttons
        addButton.addActionListener(this);
        displayButton.addActionListener(this);
        sortButton.addActionListener(this);
        searchButton.addActionListener(this);
        modifyButton.addActionListener(this);

        // Add components to panel
        panel.add(studentIdLabel);
        panel.add(studentIdField);
        panel.add(firstNameLabel);
        panel.add(firstNameField);
        panel.add(lastNameLabel);
        panel.add(lastNameField);
        panel.add(majorLabel);
        panel.add(majorField);
        panel.add(phoneLabel);
        panel.add(phoneField);
        panel.add(gpaLabel);
        panel.add(gpaField);
        panel.add(dobLabel);
        panel.add(dobField);
        panel.add(addButton);
        panel.add(displayButton);
        panel.add(sortButton);
        panel.add(searchButton);
        panel.add(modifyButton);

        // Add panel to frame
        frame.add(panel);
        frame.pack();
        frame.setVisible(true);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }


    @Override
    public void actionPerformed(ActionEvent e) {
        dbConnect db = new dbConnect();
        Connection conn;
        try {
            conn = db.getConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            throw new RuntimeException(ex);
        }
        try {
            stmt = conn.createStatement();
        } catch (SQLException e1) {
            e1.printStackTrace();
        }
        Table tb = new Table();
        if (e.getSource() == addButton) {
            // Insert new student into database
            String sql = "INSERT INTO students VALUES('" + studentIdField.getText() + "', '"
                    + firstNameField.getText() + "', '" + lastNameField.getText() + "', '" + majorField.getText()
                    + "', '" + phoneField.getText() + "', '" + gpaField.getText() + "', '" + dobField.getText() + "')";
            try {
                stmt.executeUpdate(sql);
                JOptionPane.showMessageDialog(null, "Student added successfully.");
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } else if (e.getSource() == displayButton) {
            // Display all sdata in database
            String sql = "SELECT * FROM article";

            try {
                ResultSet rs = stmt.executeQuery(sql);

                // Create table to display student data
                JTable table = new JTable(tb.buildTableModel(rs));
                JOptionPane.showMessageDialog(null, new JScrollPane(table));
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } else if (e.getSource() == sortButton) {
            // Sort sdata by selected column
            String[] options = {"First Name", "Last Name", "Major"};
            int choice = JOptionPane.showOptionDialog(null, "Sort by:", "Sort", JOptionPane.DEFAULT_OPTION,
                    JOptionPane.PLAIN_MESSAGE, null, options, options[0]);

            String sql = "";
            switch (choice) {
                case 0:
                    sql = "SELECT * FROM students ORDER BY first_name";
                    break;
                case 1:
                    sql = "SELECT * FROM students ORDER BY last_name";
                    break;
                case 2:
                    sql = "SELECT * FROM students ORDER BY major";
                    break;
                default:
                    // Handle the default case if needed.
                    break;
            }
            try {
                ResultSet rs = stmt.executeQuery(sql);

                // Create table to display student data
                JTable table = new JTable(tb.buildTableModel(rs));
                JOptionPane.showMessageDialog(null, new JScrollPane(table));
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } else if (e.getSource() == searchButton) {
            // Search for student by selected column
            String[] options = {"Student ID", "Last Name", "Major"};
            int choice = JOptionPane.showOptionDialog(null, "Search by:", "Search", JOptionPane.DEFAULT_OPTION,
                    JOptionPane.PLAIN_MESSAGE, null, options, options[0]);

            String column = "";
            switch (choice) {
                case 0:
                    column = "student_id";
                    break;
                case 1:
                    column = "last_name";
                    break;
                case 2:
                    column = "major";
                    break;
                default:
                    // Handle the default case if needed.
                    break;
            }

            String searchTerm = JOptionPane.showInputDialog("Enter search term:");

            String sql = "SELECT * FROM students WHERE " + column + " LIKE '%" + searchTerm + "%'";

            try {
                ResultSet rs = stmt.executeQuery(sql);

                // Create table to display student data
                JTable table = new JTable(tb.buildTableModel(rs));
                JOptionPane.showMessageDialog(null, new JScrollPane(table));
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } else if (e.getSource() == modifyButton) {
            // Modify selected student's data
            String studentId = JOptionPane.showInputDialog("Enter student ID:");

            String sql = "SELECT * FROM students WHERE student_id = '" + studentId + "'";

            try {
                ResultSet rs = stmt.executeQuery(sql);

                if (rs.next()) {
                    String[] options = {"First Name", "Last Name", "Major", "Phone", "GPA", "Date of Birth"};
                    int choice = JOptionPane.showOptionDialog(null, "Select field to modify:", "Modify",
                            JOptionPane.DEFAULT_OPTION, JOptionPane.PLAIN_MESSAGE, null, options, options[0]);

                    String column = "";
                    switch (choice) {
                        case 0:
                            column = "first_name";
                            break;
                        case 1:
                            column = "last_name";
                            break;
                        case 2:
                            column = "major";
                            break;
                        case 3:
                            column = "phone";
                            break;
                        case 4:
                            column = "gpa";
                            break;
                        case 5:
                            column = "date_of_birth";
                            break;
                        default:
                            // Handle the default case if needed.
                            break;
                    }
                    String newValue = JOptionPane.showInputDialog("Enter new value:");

                    sql = "UPDATE students SET " + column + " = '" + newValue + "' WHERE student_id = '" + studentId + "'";

                    stmt.executeUpdate(sql);
                    JOptionPane.showMessageDialog(null, "Student data updated successfully.");
                } else {
                    JOptionPane.showMessageDialog(null, "Student not found.");
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

}