 #version 3.7;
 global_settings{ assumed_gamma 1.0 }
 #default{ finish{ ambient 0.1 diffuse 0.9 }}
 
 // INCLUDES
 //--------------------------------------------------------------------------
 //#include "/Users/anupam/softwares/PovrayCommandLineMacV2/include/colors.inc"
 //#include "/Users/anupam/softwares/PovrayCommandLineMacV2/include/textures.inc"
 //#include "/Users/anupam/softwares/PovrayCommandLineMacV2/include/glass.inc"
 //#include "/Users/anupam/softwares/PovrayCommandLineMacV2/include/metals.inc"
 //#include "/Users/anupam/softwares/PovrayCommandLineMacV2/include/golds.inc"
 //#include "/Users/anupam/softwares/PovrayCommandLineMacV2/include/stones.inc"
 //#include "/Users/anupam/softwares/PovrayCommandLineMacV2/include/woods.inc"
 //#include "/Users/anupam/softwares/PovrayCommandLineMacV2/include/shapes.inc"
 //#include "/Users/anupam/softwares/PovrayCommandLineMacV2/include/shapes2.inc"
 //#include "/Users/anupam/softwares/PovrayCommandLineMacV2/include/functions.inc"
 //#include "/Users/anupam/softwares/PovrayCommandLineMacV2/include/math.inc"
 //#include "/Users/anupam/softwares/PovrayCommandLineMacV2/include/transforms.inc"
 
 #include "colors.inc"
 #include "textures.inc"
 #include "glass.inc"
 #include "metals.inc"
 #include "golds.inc"
 #include "stones.inc"
 #include "woods.inc"
 #include "shapes.inc"
 #include "shapes2.inc"
 #include "functions.inc"
 #include "math.inc"
 #include "transforms.inc"
 
 
 // CAMERA
 //--------------------------------------------------------------------------
 #declare Camera_Number = 1 ;
 #declare Ultra_Wide_Angle_On = 0;// don't use fish eye - for proper text
 #declare Camera_Angle    =  0 ;
 #declare Camera_Rotate = <0,0,0>; // tilling of the camera!!  
 
 //#declare Camera_Position = <0, 0, 27>; 
 //#declare Camera_Position = <0, -20, -20>; 
 
 #declare Camera_Position = <0, 0, -40>;
 
 #declare Camera_Look_At = <0, 0, 0>;
 
 
 #declare Camera = camera{ location Camera_Position
                             right    x*image_width/image_height
                             angle   Camera_Angle
                             rotate Camera_Rotate
                             rotate <0, 0, 0>
                             translate <0, 0, 0>
                             // translate <0, 0, 0>
                            look_at  Camera_Look_At
 
                           }
 
 
 camera{Camera}
 
 // light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1}  // flash light
 light_source{<0, -1000, -1000> color White}
 
 
 // GROUND
 //--------------------------------------------------------------------------
 plane { <0,0,1>, 100. // plane with layered texture
         texture { pigment{color White}
                   finish {ambient 0.8
                         diffuse 1.
                          }
                  }
       }
 
 //-----------------------------------------------------------------------------------------------------------------------------
 //---------------------------- Create filament object from .txt file with comma separated values.  ----------------------------
 //-----------------------------------------------------------------------------------------------------------------------------
 
 // filename of the center coordinate files, as a function of timestep 
 // #declare fileName = concat("/Users/nicholascharles/Documents/Research/random/test_3d_", frame_number, ".txt");   
 // #declare fileName = concat("/Users/anupam/Mahadevan/Cellular_Invasion/Two-phase/ThreeD/R20_mu10_Es40_Dfo1/pov_ray/test_3d0081.txt");   
 //#declare fileName = concat("cell_3d",frame_number,".txt");   
 
 #declare nf = 116; // Change this according to the data. 
 #declare nc = array[nf]; // array to put center coordinates into 
 #declare nfull = array[nf]; // array to put center coordinates into 
 #declare nhf = array[nf]; // array to put center coordinates into 
 #declare i = 0;
 #fopen MyFile "processed_data/ncell.txt" read
   #while (defined(MyFile))
     #read (MyFile, nn, nn1, nn2)
     #declare nc[i] = nn;
     #declare nfull[i] = nn1;
     #declare nhf[i] = nn2;
     #declare i = i+1;
   #end
 #declare nframe = frame_number-1;
 
 
 
 #declare fileNameA = concat("processed_data/cell_3d",str(frame_number,-4,0),".txt");
 #declare fileNameB = concat("processed_data/cellType_3d",str(frame_number,-4,0),".txt");

 // #declare fileNameD = concat("processed_data/matrix_3d",str(frame_number,-4,0),".txt");

 #declare fileNameE = concat("processed_data/coordn_data_proc/num_time_",str(frame_number-1,-4,0),".txt");
 
 //#declare fileName = concat("cell_3d0007.txt");   
 //#declare fileName1 = concat("datatxt/half_matrix_3d",str(frame_number,-4,0),".txt");   
 //#declare fileName1 = concat("datatxt/matrix_3d",str(frame_number,-4,0),".txt");
 
 #declare r = 0.6; // sphere radius
 //#declare n = 0310; // number of spheres
 // #declare n = 5280; // number of spheres
 #declare n = nc[nframe]; // number of spheres
 //#declare nm = 22280; // number of spheres
 //#declare nm = 93110; // number of spheres
 //#declare nm = nhf[str(frame_number,1,1)]; // number of spheres
 #declare nm = nhf[nframe]; // number of spheres
 #declare nf = nfull[nframe];
 
 #warning concat("Frame number is ", str(nframe,1,0), " and number of cells are ", str(n,5,0)," and ",str(nm,5,0),".")
 // finish, pigmentation of spheres 
 #declare fin = finish {ambient 0.3
                         diffuse 0.6
                         specular 0.6
                         roughness 0.1
                       };
 
 #declare blackGlossyFinish = finish {
     ambient 0.1
     diffuse 0.1
     specular 0.9
     reflection 0.5
     metallic 0.9
     conserve_energy
 };
 
 //#declare pig = pigment{rgb <0.05,0.05,0.65>}; // rgb pigment 
 //#declare pigc = pigment{rgbt <140/255,125/255,55/255 0.0>}; // rgb pigment 
 #declare pigm = pigment{rgbt <0.20,0.20,0.20 0.8>}; // rgb pigment 
 //#declare pigm = pigment{rgbt <0.60,0.60,0.60 0.75>}; // rgb pigment 
 //#declare pigc = pigment{rgbt <92/255,54/255,89/255 0.0>}; // rgb pigment 
 
 
 
 // read all the center coordinates into an array 
 
 #declare coordArray = array[n]; // array to put center coordinates into 
 #declare coordArraym = array[nf]; // array to put center coordinates into 
 
 //#warning str(nm,1,1)
 
 
 
 
 #fopen centerCoords fileNameA read
 #declare i = 0;
 #while (defined(centerCoords))
     #read (centerCoords, X, Y, Z)
     #declare coordArray[i] = <X,Y,Z>;
     // #debug concat("coordArray[", str(i, 0, 0), "] = ", vstr(3, coordArray[i], ", ", 1, 8), "\n")
     #declare i = i + 1;
 #end
 #fclose centerCoords // close coordinate file 
 
 
 
 
 
 
 
 
 
 //#warning str(nm,1,1)
 
 //#fopen centerCoordsM fileNameD read 
 //#declare k = 0;                                            
 //#while (defined(centerCoordsM))
 //    #read (centerCoordsM, XX, YY, ZZ)   
 //    #declare coordArraym[k] = <XX,YY,ZZ>;  
 //    // #debug concat("coordArray[", str(i, 0, 0), "] = ", vstr(3, coordArray[i], ", ", 1, 8), "\n")
 //    #declare k = k + 1; 
 //#end       
 //#fclose centerCoordsM // close coordinate file 
 
 
 
 //// Read cell types. 
 
 #declare cellTypeArr = array[n];
 #fopen cellType fileNameB read
 #declare j = 0;
 #while (defined(cellType))
   #read (cellType, XX)
   #declare cellTypeArr[j] = XX;
   #declare j = j + 1;
 #end
 #fclose cellType
 
 //// Read the coordination number (num) data first. 
 
 #declare numArr = array[n];
 #fopen numP fileNameE read
 #declare jj = 0 ;
 #while (defined(numP))
   #read (numP, XNUM)
   #declare numArr[jj] = XNUM;
 
   #warning concat("numarr",str(numArr[jj],5,0))
   #declare fileNameF = concat("processed_data/coordn_data_proc/inn_time_",str(frame_number-1,-4,0),"_cell_",str(jj+1, -4,0),".txt");
 
   #declare centerC = coordArray[jj];
 
 
 
   #declare innArr = array[numArr[jj]]
   #fopen innP fileNameF read
   #declare kk = 0;
   #while (defined(innP))
     #read (innP, XINN)
     #declare innArr[kk] = XINN;
     #warning concat("neighbors are:", str(innArr[kk], 2, 0))
 
     #declare centerN = coordArray[innArr[kk]-1];
 
 
      cylinder {
        centerC, centerN, 0.1
        texture {
          pigment {color Black}
        }
        finish {blackGlossyFinish}
      }
 
   #end
   #fclose innP
 
 
   #declare jj = jj + 1;
 
 
 
   #warning fileNameF
 
 
 #end
 #fclose numP
 
 
 
 
 
 // loop through all the cell sphere centers 
 #declare counter = 0;
 #while (counter < n)
     #declare ct = cellTypeArr[counter];
 
 
     //#declare pigc = pigment{rgbt <0,0,1 0.0>}; // rgb pigment 
 
     //#declare pigc = pigment { ct = 1 ? rgbt <0, 0, 1, 0.0> : ct = 2 ? rgbt <1, 0, 0, 0.0> : rgbt <1, 1, 1, 0.0> };
 
     #if (ct = 1)
       //#declare pigc = pigment {rgb <0, 0, 1>}
       #declare pigc = pigment {rgb <0/255,71/255,171/255>}
     #else
       #if (ct = 2)
         #declare pigc = pigment {rgb <1, 0, 0>}
       #else
         #declare pigc = pigment {rgb <0, 0, 0>}
       #end
     #end
 
     #declare center = coordArray[counter];
 
 
 
 
 //   #declare centerN = coordArray[mod(counter + 1,n)];
 
     // make the sphere                       
 
       sphere{ center, r
         pigment {pigc}
       finish {fin}
         }
 
 //   cylinder {
 //     centerC, centerN, 0.05
 //     texture {
 //       pigment {color Black}
 //     }
 //   }
 
 
 
     #declare counter = counter + 1;
 #end
 
 //// read all the center coordinates into an array 
 
 //#fopen centerCoords fileName1 read 
 //#declare i = 0;                                            
 //#while (defined(centerCoords))
 //    #read (centerCoords, X, Y, Z)   
 //    #declare coordArraym[i] = <X,Y,Z>;  
 //    // #debug concat("coordArray[", str(i, 0, 0), "] = ", vstr(3, coordArray[i], ", ", 1, 8), "\n")
 //    #declare i = i + 1; 
 //#end       
 //#fclose centerCoords // close coordinate file
 //
 //// loop through all the matrix sphere centers 
 //#declare counter = 5000;
 //#while (counter < 6000)
 //    #declare center = coordArraym[counter];
 //
 //    // make the sphere                       
 //    sphere{ center, r
 //      pigment {pigm}
 //    finish {fin}
 //      }
 //
 //    #declare counter = counter + 1; 
 //#end
 //
