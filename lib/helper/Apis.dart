const BASEURL = "http://ec2-15-207-22-80.ap-south-1.compute.amazonaws.com:3000";

const String MYPROFILE = BASEURL +
    "/my-employee-profile"; // (get api to view my profile) (headers mein token)
const String UPDATEPROFILE = BASEURL +
    "/employees"; //(put api) (token) (body: {name, email, mobile_no, password, aadhaar_no, driver_license, address, pincode})
const String LOGINEMPLOYEE = BASEURL +
    "/login-employee"; //(post requestfor login)(body: {emailOrPhone, password})
const String SETPASS =
    BASEURL + "/set-password"; // (put request)(body: {mobile_no, password})
const String ORDERS = BASEURL +
    "/delivery-order"; //  (get request to view assigned delivery orders)(headers mein token )
const String CONFIRMDELIVERY =
    BASEURL + "/receive-pickup/"; //(put api) (token) (body: {code, order_id})
const String HISTORY = BASEURL + "/past-orders";
const String INVOICE = BASEURL +"/delivery-man-invoice";
const String DELIVERYMAN =
    BASEURL + "/deliver-order/";
//packager

const String PENDINGPICKUPS = BASEURL + "/employee-pickups"; //get packager token

const String PACKAGERINVOICE = BASEURL + "/packager-invoice";

const String STOCK = BASEURL + "/stocks";

const String PENDINGPACKAGES = BASEURL +"/delivery-order";

const String REDUCEQUANTITY = BASEURL + "reduce-inventory";//put(body: {product_id: ,no_of_units:})//100 chchahiye 60 hai to 60 bhjna h is api me 
//case 2 . agar poora mal h to sirf ye chalegi body me poora no_of_units

const String INVENTORY = BASEURL + "/inventory";

const String OUTOFSTOCK = BASEURL + "/pending-products/";//put(body: {product_id: ,no_of_units:})case 1.kuch mal nahi h (total quatity bhjni h jitni pending me dalni h)
//case 2. 100 chchahiye 60 hai to 40 bhjna h is api me 

const PACKORDER = BASEURL +"/pack-order/";