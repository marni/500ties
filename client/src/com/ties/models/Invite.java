package com.ties.models;

import com.ties.utils.Model;
import com.ties.utils.SQLTableBuilder;

public class Invite extends Model {

	public final static String TABLE = Invite.class.getSimpleName();
	public final static String EMAIL = "email";
	
	@Override
	protected void onCreate(SQLTableBuilder tableBuilder){
		tableBuilder.text(EMAIL).notNull();
	}

	@Override
	protected String getTableName() {
		return TABLE;
	}

}
