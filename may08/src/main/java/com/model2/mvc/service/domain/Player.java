package com.model2.mvc.service.domain;

public class Player {

	private String playerNumber;
	private String playerName;
	private String teamName;
	private String playerPosition;
	private String playerHeight;
	private String playerWeight;
	
	public Player() {
		
	}
	public String getPlayerNumber() {
		return playerNumber;
	}
	public void setPlayerNumber(String playerNumber) {
		this.playerNumber = playerNumber;
	}
	public String getPlayerName() {
		return playerName;
	}
	public void setPlayerName(String playerName) {
		this.playerName = playerName;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public String getPlayerPosition() {
		return playerPosition;
	}
	public void setPlayerPosition(String playerPosition) {
		this.playerPosition = playerPosition;
	}
	public String getPlayerHeight() {
		return playerHeight;
	}
	public void setPlayerHeight(String playerHeight) {
		this.playerHeight = playerHeight;
	}
	public String getPlayerWeight() {
		return playerWeight;
	}
	public void setPlayerWeight(String playerWeight) {
		this.playerWeight = playerWeight;
	}
	
	public String toString() {
		return "[playerNumber] : "+playerNumber+"[playerName] : "+playerName+"[teamName] : "+teamName+"[playerPosition] : "
	            +playerPosition+"[playerHeight] : "+playerHeight+"[playerWeight] : "+playerWeight;
	}
}
