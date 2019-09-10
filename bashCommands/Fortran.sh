
echo next
docker pull sconecuratedimages/crosscompilers
docker run --device=/dev/isgx -it sconecuratedimages/crosscompilers
echo next
scone gfortran --help
echo next
cat > gcd.f << EOF
*     euclid.f (FORTRAN 77)
*     Find greatest common divisor using the Euclidean algorithm

      PROGRAM EUCLID
        PRINT *, 'A?'
        READ *, NA
        IF (NA.LE.0) THEN
          PRINT *, 'A must be a positive integer.'
          STOP
        END IF
        PRINT *, 'B?'
        READ *, NB
        IF (NB.LE.0) THEN
          PRINT *, 'B must be a positive integer.'
          STOP
        END IF
        PRINT *, 'The GCD of', NA, ' and', NB, ' is', NGCD(NA, NB), '.'
        STOP
      END

      FUNCTION NGCD(NA, NB)
        IA = NA
        IB = NB
    1   IF (IB.NE.0) THEN
          ITEMP = IA
          IA = IB
          IB = MOD(ITEMP, IB)
          GOTO 1
        END IF
        NGCD = IA
        RETURN
      END
EOF
echo next
scone gfortran gcd.f -o gcd
echo next
SCONE_VERSION=1 ./gcd << EOF
10
15
EOF