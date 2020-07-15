pragma solidity ^0.4.25;
contract smartfreight{
    address ceo;
    uint latitude;
    uint longitude;
    bool status = true;
    constructor(){
        ceo = msg.sender;
    }
    modifier onlyCeo(){
        require(checkOwnership());
        _;
    }
    function checkOwnership() public view returns (bool){
        return msg.sender == ceo;
    }
    event lockedAt(uint _lat,uint _long,bool _status);
    event unlockedAt(uint _lat,uint _long);
    event unauthorizedAttempt(uint _lat,uint _long);
    function setLocation(uint _lat,uint _long) external onlyCeo{
        latitude = _lat;
        longitude = _long;
        status = false;
        emit lockedAt(_lat,_long,status);
        
    }
    
    function UnlockLock(uint _lat,uint _long) external view returns (bool){
        require(_lat == latitude && _long == longitude);
            status = true;
            emit unlockedAt(_lat,_long);
            return true;
        if(_lat != latitude || _long == longitude)
        emit unauthorizedAttempt(_lat,_long);
    }
    function showDestination() external view returns(uint256,uint256,bool) {
        return (latitude,longitude,status);
    }
    
}
