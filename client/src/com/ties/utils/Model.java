package com.ties.utils;

import android.database.sqlite.SQLiteDatabase;

public abstract class Model {

	public static final String ID = "_id";
	
	protected void preCreate(SQLTableBuilder tableBuilder){
		tableBuilder.integer(ID).pk();
	}
	
	protected void onCreate(SQLTableBuilder tableBuilder){
		//override it
	}
	
	protected abstract String getTableName();

	public void create(SQLiteDatabase db) {
		SQLTableBuilder tableBuilder = new SQLTableBuilder(getTableName());
		preCreate(tableBuilder);
		onCreate(tableBuilder);
		db.execSQL(tableBuilder.sql());
	}

}
