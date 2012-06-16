package com.ties;

import com.ties.utils.Factory;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;

public class InviteActivity extends Activity{
	
	private Factory factory;
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.invite);
		
		factory = new Factory(this);
	}
	
	public void inviteButtonClicked(View view){
		EditText emailInput = (EditText) findViewById(R.id.emailInput);
		String email = emailInput.getText().toString();
		
		factory.getInviteDAO().insert(email);
	}
}
