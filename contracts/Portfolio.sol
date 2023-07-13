// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Portfolio{
//  0x9a53574c86B974839c3A9A9BadAf1c20F19c3406
//  0x87f3951d582620ec94b7701fE8c4C12F2b086F6B
  struct Project{
      uint id;
      string name;
      string description;
      string image;
      string githubLink;
  }

  struct Education{
      uint id;
      string date;
      string degree;
      string knowledgeAcquired;
      string instutionName;
  }
  
  struct Experience{
      uint id;
      string date;
      string post;
      string knowledgeAcquired;
      string compamyName;
  }

  Project[3] public projects;
  Education[3] public educationDetails;
  Experience[3] public experienceDetails;

  string public imageLink="QmSjiH4FLeLabWZruw4ZsJfwydKKRdyUPd84gg3i639Qr3";
  string public description="a good knowledge in blockchain development.i help web3 community by contributing in the web3 space.";
  string public resumeLink="QmTYG6xTsWvnK7NWUeDt9vZHT9a4YMmcD7mg1VAf2Z9uHT";
  uint projectCount;
  uint educationCount;
  uint experienceCount;
  address public manager;

  constructor(){
      manager=msg.sender;
  }

  modifier onlyManager(){
      require(manager==msg.sender,"You are not the manager");
      _;
  }
  
  function insertProject(string calldata _name,string calldata _description,string calldata _image,string calldata _githubLink) external{
      require(projectCount<3,"Only 3 projects allowed");
      projects[projectCount] = Project(projectCount,_name,_description,_image,_githubLink);
      projectCount++;
  }

  function changeProject(string calldata _name,string calldata _description,string calldata _image,string calldata _githubLink,uint _projectCount) external{
       require(_projectCount>=0 && _projectCount<3,"Only 3 projects allowed");
      projects[projectCount] = Project(_projectCount,_name,_description,_image,_githubLink);
  }
    function allProjects() external view returns(Project[3] memory){
        return projects;
    }

   function insertEducation(string calldata _date,string calldata _degree,string calldata _knowledgeAcquired,string calldata _instutionName) external  onlyManager{
     require(educationCount<3,"Only 3 education details allowed");
     educationDetails[educationCount]=Education(educationCount,_date,_degree,_knowledgeAcquired,_instutionName);
     educationCount++;
    }

  function changeEducation(string calldata _date,string calldata _degree,string calldata _knowledgeAcquired,string calldata _instutionName,uint _educationDetailCount) external onlyManager{
      require(_educationDetailCount>=0 && _educationDetailCount<3,"Invalid educationCount");
      educationDetails[_educationDetailCount]=Education(_educationDetailCount,_date,_degree,_knowledgeAcquired,_instutionName);
  }

    function allEductationDetails() external view returns(Education[3] memory){
      return educationDetails;
  }

    function insertExperience(string calldata _date,string calldata _post,string calldata _knowledgeAcquired,string calldata _companyName) external  onlyManager{
     require(experienceCount<3,"Only 3 education details allowed");
     experienceDetails[experienceCount]=Experience(experienceCount,_date,_post,_knowledgeAcquired,_companyName);
     experienceCount++;
    }

    function changeExperience(string calldata _date,string calldata _post,string calldata _knowledgeAcquired,string calldata _companyName,uint _experienceDetailCount) external  onlyManager{
     require(_experienceDetailCount>=0 && _experienceDetailCount<3,"Invalid experienceCount");
     experienceDetails[_experienceDetailCount]=Experience(_experienceDetailCount,_date,_post,_knowledgeAcquired,_companyName);
    }
    
    function allExperienceDetails() external view returns(Experience[3] memory){
      return experienceDetails;
    }
  function changeDescription(string calldata _description) external{
      description=_description;
  }

    function changeResumeLink(string calldata _resumeLink) external onlyManager{
      resumeLink=_resumeLink;
  }
     function changeImageLink(string calldata _imageLink) external onlyManager{
      imageLink=_imageLink;
  }

  function donate() public payable{
      payable(manager).transfer(msg.value);
  }

}