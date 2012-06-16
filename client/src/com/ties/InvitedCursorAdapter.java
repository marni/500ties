package com.ties;

import com.ties.models.Invite;

import android.content.Context;
import android.database.Cursor;
import android.widget.SimpleCursorAdapter;

public class InvitedCursorAdapter extends SimpleCursorAdapter {

	public InvitedCursorAdapter(Context context, Cursor cursor) {
		super(context, android.R.layout.simple_list_item_1, cursor,
				new String[] { Invite.EMAIL }, new int[] { android.R.id.text1 });
	}

	@Override
	public CharSequence convertToString(Cursor cursor) {
		String name = cursor.getString(cursor.getColumnIndex(Invite.EMAIL));
		return name;
	}

}
