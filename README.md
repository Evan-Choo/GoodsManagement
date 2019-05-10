## 《Web design》 Experimental report 

### **1.Experimental purposes, Cases and Requirements:**

**Experimental purposes:**

Web client development technology: HTML+CSS+JAVASCRIPT. Web server development technology: JSP, using JSP to access database system.

**Experimental Cases:**

1、Roles in online shopping website: Administrator and user

2、Online shopping website functions:

① User login information validation and processing: If both user name and password are correct, then enter the online shopping homepage and allow purchasing goods, otherwise steer error handling page and gives an error message, after that,  return to the login page. Design error handling page, handling errors. Correctness of a user name and password is verified by the database.

② User registration: if the new name is not registered by other users, this new user registration information is saved to the database. In the meanwhile, other information, such as email address format, QQ number (not allow not-numeric), etc, is also verified. 

③ Adding modifying and deleting merchandise and its category: This function is only visible to the administrator role. Note added goods must belong to a certain category. It is not allowed to modify the ID number when modifying a product.

④ Merchandise classification display: When entering the online shopping homepage, you should be able to display product information according to the category information stored in the database: for example, books category, electronic products category and etc. For each category, you should also be able to display the latest product information.

⑤ Product list and product details display: After selecting the product category, you can display the list of goods belonging to the same category in pagination display way, after the user clicks a product title, you can jump to the details display page of the product. 

⑥ Implementing shopping function: in product list and product details display page, click "Add to Cart" to add one or more products to a cart, and give all product information and the total amount of money in the shopping cart. You can also delete an item from this shopping cart. After finishing shopping, a shopping order will be generated. In addition, you can click "continue shopping" on the shopping cart page to jump back to the online shopping home page to continue shopping.

------



**2.Experimental environment**: experiment with the hardware and software environment (configuration)

==Hardware: MacBook Pro, Intel i7==

==Software: Intellij IDEA, Tomcat 9.0.19, MySQL 5.7.2, JDBC 5.1.47，jakarta-taglibs-standard-1.1.2==

**3.Experimental Design:**Describe the structure and layout of the site, indicate that the site designing ideas and designing steps, draw diagrams of relationships between each page, and give descriptions about diagrams.

 ![Image](/Users/evanchoo/Desktop/Image.jpeg)

The structure of the whole website is the picture above. The website starts with the `index.jsp` and can then jump to `admin_page.jsp`, `user_page.jsp`  or `sign_up.html` using the validation of `admin_validation.jsp` and `user_validation.jsp`. If there exists any error like the **user's password is wrong** or **the user doesn't exists** or **the registration email has already been taken**, then the webiste will jump to `error.jsp` with the **error message** shown.

In `user_page.jsp`, user can view the detail of a good by clicking the **View Detail** button and can add a specific good to his/her shopping cart by clicking the **Add To Cart** button. Moreover, the user can browse the goods by category. Detail will be shown using `view_detail.jsp` and the shopping cart uses `shopping_cart.jsp`. The **Add To Cart** button and **browse by category** function are implemented by `add_to_cart.jsp` and `select_cara.jsp` respectively. In the shopping cart, user can delete the goods by clicking **DELETE** button and the goods will be put back to the inventory. And user can check out by clicking **Check out** button.

In `admin_page.jsp`, admin can edit the good information, delete a good, add a category and add a new good. The are achieved by `edit_good.jsp`, `delete_good.jsp`, `add_catagory.jsp` and `add_new_good.jsp`. If the action involve input some information by the user, e.g. when you edit the good, you need to enter the new information, the accessing database and write data part of job will be done in the JSP file begin with `after-`.

In the `sign_up.html`, the format correctness of the user's input is examined by **Javascript**. For example, if the user hasn't input his/her user name or the format of the emial is not correct or the two password are not the same, there will be a message box prompting, reminding the user that there is a mistake. Other errors like the email has already been registed will be implemented in the `sign_up_validation.jsp`.

**4.Experimental** **results**

==At `index.jsp`, when the user hasn't input password and hit **User Login**==

 ![Screen Shot 2019-05-10 at 5.30.04 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.30.04 PM.png)



![Screen Shot 2019-05-10 at 5.31.40 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.31.40 PM.png)

==Browse by category==

![Screen Shot 2019-05-10 at 5.36.24 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.36.24 PM.png)

![Screen Shot 2019-05-10 at 5.37.47 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.37.47 PM.png)

==View good detail. Different kinds of goods will be displayed differently. Like the **eletronic device** has information about its **debut year** whereas **book** has their **ISBN number** presented.==

 ![Screen Shot 2019-05-10 at 5.31.36 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.31.36 PM.png)

![Screen Shot 2019-05-10 at 5.34.32 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.34.32 PM.png)

==If we add a good which is out of stock to the shopping cart, there will be an error indicating the good has run out of stock and thus can't be added to the shopping cart.== 

==For example, we add *Minna no Nihongo* to the cart. And then get the following page.==

![Screen Shot 2019-05-10 at 5.35.36 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.35.36 PM.png)

==This is the cart before we add an iPhone XS and a *Head First Servlets and JSP* to our cart.==

![Screen Shot 2019-05-10 at 6.50.23 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 6.50.23 PM.png)

==And then we click add to cart respectively.==

![Screen Shot 2019-05-10 at 5.35.14 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.35.14 PM.png)

==And now our cart is like the following.==

![Screen Shot 2019-05-10 at 6.50.41 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 6.50.41 PM.png)

==And then we check out. And get the following.== ![Screen Shot 2019-05-10 at 5.38.02 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.38.02 PM.png)

==Click back we go to our shopping cart and now it's empty.==

![Screen Shot 2019-05-10 at 6.50.23 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 6.50.23 PM.png)

==In `sign_up.html` page we can register our account. If we don't input anything and hit **Sign Up**, there will be a prompt.==

![Screen Shot 2019-05-10 at 5.40.14 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.40.14 PM.png)

==If the two passwords are not the same.==

 ![Screen Shot 2019-05-10 at 5.40.34 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.40.34 PM.png)

==And invalid email address.==

![Screen Shot 2019-05-10 at 5.40.54 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.40.54 PM.png)

==If we use an email that's already been registed.==

![Screen Shot 2019-05-10 at 5.45.11 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.45.11 PM.png)

![Screen Shot 2019-05-10 at 5.45.15 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.45.15 PM.png)

If everything is fine, we can go to the `user_page.jsp`.

![Screen Shot 2019-05-10 at 7.00.51 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 7.00.51 PM.png)

![Screen Shot 2019-05-10 at 7.00.24 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 7.00.24 PM.png)

Admin can't registed for safty concerns. After you get the right admin email and password, you can go to the `admin_page.jsp`

![Screen Shot 2019-05-10 at 5.46.23 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.46.23 PM.png)

You can edit good information. For example, if we hit the **Edit info** for **Camera**

![Screen Shot 2019-05-10 at 5.46.35 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.46.35 PM.png)

We change the name. And the prompt appears.

![Screen Shot 2019-05-10 at 5.47.15 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.47.15 PM.png)

And then the name is changed.

![Screen Shot 2019-05-10 at 5.47.22 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.47.22 PM.png)

If we change the category of it. We must fill the according information. Otherwise we get a prompt.

![Screen Shot 2019-05-10 at 5.47.31 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.47.31 PM.png)

![Screen Shot 2019-05-10 at 5.47.35 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.47.35 PM.png)

If we delete the good, we need to confirm it. Click **OK** and we can delete it.

![Screen Shot 2019-05-10 at 5.49.37 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.49.37 PM.png)

![Screen Shot 2019-05-10 at 5.49.40 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.49.40 PM.png)

Admin can also add a new category by clicking **Add Category**.

![Screen Shot 2019-05-10 at 5.49.51 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.49.51 PM.png)

And click **OK**

![Screen Shot 2019-05-10 at 5.49.57 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.49.57 PM.png)

And now we can see that there is a new category.

![Screen Shot 2019-05-10 at 5.50.08 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.50.08 PM.png)

Finally we can add a new good by clicking **Add New Good**.

![Screen Shot 2019-05-10 at 5.50.38 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.50.38 PM.png)

Clicking OK to confirm.

![Screen Shot 2019-05-10 at 5.50.50 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.50.50 PM.png)

And see, there is a new good now.

![Screen Shot 2019-05-10 at 5.50.57 PM](/Users/evanchoo/Desktop/Screen Shot 2019-05-10 at 5.50.57 PM.png)

**5.Summary:** give your thoughts and suggestions.

 This experiment of a small goods system is mainly implemented using JSP and some servlets(they are added at the early time and were deprecated after). The whole development prcoess took about 3 days. From my point of view, web programming is mainly about dealing with request, maintaining user state using session and interacting with database. However, it's also closely related to other common techniques. Like the MVC model and use of .xml configuration file.

The biggest harvest I had this time is that I can now clearly understand the process of web request and response and have a clear mind of the structure of Tomcat server side, and the lifecycle of a JSP. More over, I learnt the services a web container can provide like maintaining a session attribute or context parameters.

And I also got some insight on how to write more sophiscated and robust programs. Like, we should get rid of hard-encoding at our best try and try to use a programming-in-general way, like put the parameters that may change later in a .xml configuration file and so on.

 

 
