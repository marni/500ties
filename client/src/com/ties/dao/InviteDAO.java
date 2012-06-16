package com.ties.dao;

import android.content.ContentValues;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import com.ties.models.Invite;

public class InviteDAO {
	protected SQLiteDatabase db;
	
	public InviteDAO(SQLiteDatabase db) {
		this.db = db;
	}
	
	public long insert(String email) {
		ContentValues values = new ContentValues();
		values.put(Invite.EMAIL, email);
		return db.insert(Invite.TABLE, null, values);
	}
	
	public Cursor list(){
		return db.query(Invite.TABLE, null, null, null, null, null, null);
	}

}
