package com.ties.utils;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import com.ties.dao.InviteDAO;

public class Factory {
	protected SQLiteDatabase db;
	
	protected InviteDAO inviteDAO;
	
	public Factory(Context context) {
		db = new DatabaseHelper(context).getWritableDatabase();
	}
	
	public InviteDAO getInviteDAO() {
		if(inviteDAO == null){
			inviteDAO = new InviteDAO(db);
		}
		return inviteDAO;
	}
	
	public void closeDatabase(){
		db.close();
	}
	
}
