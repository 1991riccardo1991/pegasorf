package erreeffe.entity;

// Generated 20-nov-2008 2.05.45 by Hibernate Tools 3.2.2.GA

import java.util.List;
import javax.naming.InitialContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.SessionFactory;
import static org.hibernate.criterion.Example.create;

/**
 * Home object for domain model class ContoBancario.
 * @see erreeffe.entity.ContoBancario
 * @author Hibernate Tools
 */
public class ContoBancarioHome {

	private static final Log log = LogFactory.getLog(ContoBancarioHome.class);

	private final SessionFactory sessionFactory = getSessionFactory();

	protected SessionFactory getSessionFactory() {
		try {
			return (SessionFactory) new InitialContext()
					.lookup("SessionFactory");
		} catch (Exception e) {
			log.error("Could not locate SessionFactory in JNDI", e);
			throw new IllegalStateException(
					"Could not locate SessionFactory in JNDI");
		}
	}

	public void persist(ContoBancario transientInstance) {
		log.debug("persisting ContoBancario instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(ContoBancario instance) {
		log.debug("attaching dirty ContoBancario instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(ContoBancario instance) {
		log.debug("attaching clean ContoBancario instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(ContoBancario persistentInstance) {
		log.debug("deleting ContoBancario instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public ContoBancario merge(ContoBancario detachedInstance) {
		log.debug("merging ContoBancario instance");
		try {
			ContoBancario result = (ContoBancario) sessionFactory
					.getCurrentSession().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public ContoBancario findById(long id) {
		log.debug("getting ContoBancario instance with id: " + id);
		try {
			ContoBancario instance = (ContoBancario) sessionFactory
					.getCurrentSession().get("erreeffe.entity.ContoBancario",
							id);
			if (instance == null) {
				log.debug("get successful, no instance found");
			} else {
				log.debug("get successful, instance found");
			}
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List<ContoBancario> findByExample(ContoBancario instance) {
		log.debug("finding ContoBancario instance by example");
		try {
			List<ContoBancario> results = (List<ContoBancario>) sessionFactory
					.getCurrentSession().createCriteria(
							"erreeffe.entity.ContoBancario").add(
							create(instance)).list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
}
