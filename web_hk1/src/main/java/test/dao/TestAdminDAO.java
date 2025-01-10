package test.dao;

import database.DbConnection;
import database.dao.AdminDAO;

public class TestAdminDAO {

    public static void Test_GetAllAdmin(){
        AdminDAO dao = new AdminDAO();
        DbConnection connectDB = DbConnection.getInstance();
        System.out.println(dao.getAllAdmin(connectDB));
    }

    public static void Test_GetAllRoleAdmin(){
        AdminDAO dao = new AdminDAO();
        DbConnection connectDB = DbConnection.getInstance();
        System.out.println(dao.getAllRoleAdmin(connectDB));
    }

    public static void Test_GetAllStatusAcc(){
        AdminDAO dao = new AdminDAO();
        DbConnection connectDB = DbConnection.getInstance();
        System.out.println(dao.getAllStatusAcc(connectDB));
    }

    public static void main(String[] args) {

        //Test_GetAllAdmin();

        Test_GetAllRoleAdmin();
        System.out.println("-----------------");
        Test_GetAllStatusAcc();
    }
}
