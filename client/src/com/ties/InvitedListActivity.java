package com.ties;

import android.app.ListActivity;
import android.database.Cursor;
import android.os.Bundle;

import com.ties.utils.Factory;

public class InvitedListActivity extends ListActivity {
	
	private InvitedCursorAdapter adapter;
	private Factory factory;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		
		factory = new Factory(this);
		Cursor cursor = factory.getInviteDAO().list(); 
		adapter = new InvitedCursorAdapter(this, cursor);
		
		//Assign adapter to ListView
		getListView().setAdapter(adapter);
	}
}
