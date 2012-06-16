package com.ties.utils;

import java.util.LinkedList;
import java.util.List;

import android.util.Log;

public class SQLTableBuilder {

	protected enum Type {
		INTEGER, TEXT, TIMESTAMP, BLOB;
	}

	public class Column {
		String name;
		String foreignKeyTable;
		String foreignKeyColumn;
		String defaultValue;
		Type type;
		boolean primaryKey;
		boolean foreignKey;
		boolean autoincrement;
		boolean notNull;
		boolean unique;

		protected String sql() {
			StringBuilder sql = new StringBuilder(name);
			sql.append(" ");
			sql.append(type.toString());
			if (primaryKey && primaryKeys.size() == 1) {
				sql.append(" PRIMARY KEY");
				if (autoincrement) {
					sql.append(" AUTOINCREMENT");
				}
			}
			if (notNull) {
				sql.append(" NOT NULL");
			}
			if (unique) {
				sql.append(" UNIQUE");
			}
			if (defaultValue != null && defaultValue.trim().length() > 0) {
				sql.append(" DEFAULT '");
				sql.append(defaultValue);
				sql.append("'");
			}
			return sql.toString();
		}

		public Column pk() {
			primaryKey = true;
			primaryKeys.add(this);
			return this;
		}

		public Column fk(String table, String column) {
			foreignKey = true;
			foreignKeyTable = table;
			foreignKeyColumn = column;
			foreignKeys.add(this);
			return this;
		}

		public Column autoInc() {
			autoincrement = true;
			return this;
		}

		public Column notNull() {
			notNull = true;
			return this;
		}
		
		public Column unique() {
			unique = true;
			return this;
		}

		public Column defaultValue(String value) {
			defaultValue = value;
			return this;
		}
	}

	protected List<Column> columns = new LinkedList<Column>();
	protected List<Column> primaryKeys = new LinkedList<Column>();
	protected List<Column> foreignKeys = new LinkedList<Column>();
	protected String tableName;

	public SQLTableBuilder(String tableName) {
		super();
		this.tableName = tableName;
	}

	protected Column createColumn(String name, Type type) {
		Column column = new Column();
		column.name = name;
		column.type = type;
		columns.add(column);
		return column;
	}

	public Column bool(String name) {
		return createColumn(name, Type.INTEGER);
	}

	public Column integer(String name) {
		return createColumn(name, Type.INTEGER);
	}

	public Column text(String name) {
		return createColumn(name, Type.TEXT);
	}

	public Column timestamp(String name) {
		return createColumn(name, Type.TIMESTAMP);
	}
	
	public Column blob(String name) {
		return createColumn(name, Type.BLOB);
	}

	public String sql() {
		StringBuilder sql = new StringBuilder("CREATE TABLE ");
		sql.append(tableName);
		sql.append("(");

		for (int i = 0; i < columns.size(); i++) {
			sql.append(columns.get(i).sql());
			if (i < columns.size() - 1) {
				sql.append(", ");
			}
		}

		if (primaryKeys.size() > 1) {
			sql.append(", PRIMARY KEY(");
			for (int i = 0; i < primaryKeys.size(); i++) {
				sql.append(primaryKeys.get(i).name);
				if (i < primaryKeys.size() - 1) {
					sql.append(", ");
				}
			}
			sql.append(")");
		}

		for (Column foreignKey : foreignKeys) {
			sql.append(", FOREIGN KEY(");
			sql.append(foreignKey.name);
			sql.append(") REFERENCES ");
			sql.append(foreignKey.foreignKeyTable);
			sql.append("(");
			sql.append(foreignKey.foreignKeyColumn);
			sql.append(")");
		}

		sql.append(");");

		String result = sql.toString();
		Log.v(this.getClass().toString(), result);

		return result;
	}

}
