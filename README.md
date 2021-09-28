
![alt tag](screen-porto-tech-center.jpg)

Jumia Porto Tech Center (PTC) is an Agile IT development center, with around 200 IT-specialists, 
where you will have the opportunity to participate in developing smart solutions for our group companies. 
We do e-commerce shops, logistics, business intelligence and mobile applications involving a wide range of high-end technologies for tens of millions customers.  

You can check our job opportunities at our site: https://group.jumia.com/careers.  

We are passionate about what we do, and we have fun while doing it. 

We will offer you second home where you will find the opportunity for growth and career development.
You will have the opportunity to earn the bonus based on your excellent results. 
The benefit list includes but is not limited to health insurance, parental bonus, snacks and fruits.

This repo represents the current admission test that is needed to apply for an iOS Developer Position.

iOS Challenge:
-

Create an app that is able to **search**, **display** and **show details of products**.

After finished, create a **pull request** and **write a description about your implementation**.


Required tech implementations:
-
- MVVM or VIPER Architecture
- Reactive Programming (Rxswift , RxCoca )
- Use Xib files and appropriate constrains for the UI Design
- Unit Testing

We value the following implementations (but not required):
-
- UITesting
- Animations
- Using  SwiftUI Views along side UIKit Views.
- Combine along side Rxswift
- Testing Report ( BDD Formate).


Description:
-

The application should be composed by:

    - Splash screen 
    - Search page 
    - Result list page 
    - Item detail page

The following requirements need to be met:

The search must be able to list items from a query.

1. The splash screen:
    - It's a loading page to request and save some configurations to be used. 

2. The search page:
    - It's a page that allow the submission of a query to get a result, like Google Search.
    - It can be in the same page as the result list page

3. The result list page:
    - It's a page that shows the query and respective result, like Google Search.
    - For each result item, the following should be displayed:
        - Image;
        - Name and brand;
        - Price, old price and discount;
        - Rating;

4. The item detail page:
    - It's a page that shows the information about the selected item
    - The following should be displayed:
        - Image or image gallery;
        - Name and brand;
        - Price, old price and discount;
        - Rating;
        - Description;

Mock API: 
-

NOTES: 

<b>Please take into consideration that some requests will give back errors, treat them accordingly.</b>

The mocklab API is based in JSON mocks and only supports the following requests:

- Get configurations

    > http://nd7d1.mocklab.io/configurations/
    
    The currency should used to format the price and old price.

- Get list items with pagination

    > http://nd7d1.mocklab.io/search/phone/page/1/
    
    > http://nd7d1.mocklab.io/search/phone/page/2/

    Parameters:
    - *"phone"* - the query
    - *"1"* - the page number (pagination)

- Get detail item

    > http://nd7d1.mocklab.io/product/1/

    > http://nd7d1.mocklab.io/product/2/

    Parameters:
    - *"1"* - the product identifier "sku"
    
    
- Failure cases

    HTTP 200 - Success false:
    > http://nd7d1.mocklab.io/product/3/
    
    HTTP 404 - Not Found:
    > http://nd7d1.mocklab.io/search/phone/page/2/
    
    > http://nd7d1.mocklab.io/product/4/

///////////////////////
what I have Achieved in points :
1- Add network layer
2-use MVVM-C design Architecture to separate navigation from view
3-Use RXSwift
4-Add Animation
5-implement all the 4 views
  - Splash screen 
  - Search page 
  - Result list page 
  - Item detail page
6-Handel failure cases
7- attached a small video to the app running "tryJumia.mov"