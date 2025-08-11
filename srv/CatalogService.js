const { default: cds } = require("@sap/cds");
 
module.exports = cds.service.impl( async function(){
    // Step - 1 : Get the object of our ODATA Entities
    const { EmployeeSet, POs } = this.entities;
     // Declaring the utilities variable
     const { uuid, decodeURI } = cds.utils;
     // Step - 2 : Define our generic handler for pre-check
    this.before('UPDATE', EmployeeSet, (req, res) => {
        console.log("Salary :"+ req.data.salary);
        if(parseFloat(req.data.salary) > 100000 && req.data.Currency_code === 'USD'){
            req.error(500,"Salary must not be more than 100000");
        }
    });
 
    this.on('discountOnPrice', async(req, res) => {--sortMessages
        try{
            // Step - 1 : Get the parameters
            const ID = req.params[0];
            console.log("Order ID : " + req.params[0] + "will be discounted..!");
            // Step - 2 : Define the transaction using cds.tx
            const tx = cds.tx(req);
            // Step - 3 : Perform action for the transaction. If you are using async function then you have to use await to call
            await tx.update(POs).with({
                GROSS_AMOUNT : { '-=' : 1000 },
                NOTE: 'Discounted..!'
            }).where(ID);
            console.log("Successfully discounted..!");
        } catch(error){
            return "Error : " + error.toString();
        }
    });
    this.on('getOrderDefaults', async(req)=>{
        return {OVERALL_STATUS: 'N'};
    });
    this.on('biggestOrder', async(req, res) => {
        try {
            // Step - 1 : Get the parameters
            let id = uuid();
            let input = "%E0%A4%A";
            const ID = req.params[0];
            // Step - 2 : Define the transaction using cds.tx
            const tx = cds.tx(req);
            // SELECT * UPTO 1 ROW FROM <POs> ORDER BY GROSS_AMOUNT desc;
            const response = await tx.read(POs).orderBy({
                GROSS_AMOUNT : 'desc'
            }).limit(1);
            console.log("UUID",id);
            console.log("After Decoding", decodeURI(input));
            return response;
        } catch (error) {
            return "Error : " + error.toString();
        }
    });
    this.on('getAllEmployees', async(req, res) => {
        const sort_column = 'NAMEFIRST';
        try{
            const q = SELECT `from COM_TCS_SD_SOA_DB_MASTER_EMPLOYEES {
                NAMEFIRST, NAMELAST, PHONENUMBER, EMAIL, SALARY
            } order by ${sort_column} asc`
            return q;
 
        } catch(error){
            return "Error : " + error.toString();
        }
    });
    this.on('getEmployee', async(req, res) => {
        const where_condition1 = req.data.name;
        const sort_column = 'NAMEFIRST';
        try{
            const q = SELECT `from COM_TCS_SD_SOA_DB_MASTER_EMPLOYEES {
                NAMEFIRST, NAMELAST, PHONENUMBER, EMAIL, SALARY
            } where NAMEFIRST = ${where_condition1} order by ${sort_column} asc`
            return q;
 
        } catch(error){
            return "Error : " + error.toString();
        }
    });
    this.on('updateSalaryOfEmployee', async(req, res) => {
        const where_condition1 = req.data.name;
        const salaryAmount = 100000;
        try{
            const q = UPDATE `COM_TCS_SD_SOA_DB_MASTER_EMPLOYEES`.set `SALARY = ${salaryAmount}`.where `NAMEFIRST = ${where_condition1}`
            return q;
 
        } catch(error){
            return "Error : " + error.toString();
        }
    });
})