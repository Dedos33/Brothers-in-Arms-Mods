
class Cfg3DEN
{
    class Group
    {
        class AttributeCategories
        {
            class MAI_Attributes
            {
                displayName = "Madin AI";
                collapsed  = 0;

                class Attributes
                {
                    class MAI_AIgroupEnableAi
                    {
                        //--- Mandatory properties
                        displayName = "$STR_MAI_AIgroupEnableAi";
                        tooltip = "$STR_MAI_AIgroupEnableAiTip";
                        property = "MadinAI";
                        control = "Checkbox";
                        expression = "_this setVariable ['MadinAI', _value, true];";
                        defaultValue = "true";
                        condition = "objectBrain"; // https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Condition
                        typeName = "BOOL";
                    };
                };
            };
        };
    };
};